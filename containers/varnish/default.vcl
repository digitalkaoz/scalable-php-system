
director d1 round-robin {
}

sub vcl_recv {
    set req.grace = 30s;
    set req.backend = d1;
    set req.http.Surrogate-Capability = "abc=ESI/1.0";

    if (req.restarts == 0) {
        if (req.http.x-forwarded-for) {
            set req.http.X-Forwarded-For = req.http.X-Forwarded-For + ", " + client.ip;
        } else {
            set req.http.X-Forwarded-For = client.ip;
        }
    }

    if (req.request != "GET" && req.request != "HEAD" && req.request != "PUT" && req.request != "POST" && req.request != "TRACE" && req.request != "OPTIONS" && req.request != "DELETE") {
        return (pipe);
    }

    if (req.request != "GET" && req.request != "HEAD") {
        return (pass);
    }

   remove req.http.Authorization;

   return (lookup);
}

sub vcl_fetch {
    # ESI processing
    if (beresp.http.Surrogate-Control ~ "ESI/1.0") {
        unset beresp.http.Surrogate-Control;
        set beresp.do_esi = true;
    }

    # do not cache 404
    if (beresp.status == 404) {
        set beresp.ttl = 120 s;
        set beresp.http.Cache-Control = "max-age=0";

        return (hit_for_pass);
    }

    set beresp.http.X-Backend = beresp.backend.name;

    if (beresp.http.Cache-Control ~ "public") {
        remove beresp.http.Set-Cookie;
    } else if (beresp.http.Cache-Control ~ "no-cache") {
        set beresp.ttl = 120s;

        return (hit_for_pass);
    }
}

sub vcl_deliver {
    if (obj.hits > 0) {
        set resp.http.X-Cache = "HIT";
    }
    else {
        set resp.http.X-Cache = "MISS";
    }

    return (deliver);
}

sub vcl_error {
    if (obj.status >= 500 && obj.status <= 505) {
        set obj.http.Content-Type = "text/html; charset=utf-8";
        if (req.url ~ "^/_fragment\?.*") {
            synthetic {""};
        } else {
            synthetic {"
                <html>
                <head>
                </head>
                <body>
                </body>
                </html>
           "};
        }
    }

    return (deliver);
}
