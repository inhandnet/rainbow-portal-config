/*! jQuery v1.11.1 | (c) 2005, 2014 jQuery Foundation, Inc. | jquery.org/license */

/*  Prototype JavaScript framework, version 1.7.1
 *  (c) 2005-2010 Sam Stephenson
 *
 *  Prototype is freely distributable under the terms of an MIT-style license.
 *  For details, see the Prototype web site: http://www.prototypejs.org/
 *
 *--------------------------------------------------------------------------*/

/**
 * @license RequireJS text 2.0.12 Copyright (c) 2010-2014, The Dojo Foundation All Rights Reserved.
 * Available via the MIT or new BSD license.
 * see: http://github.com/requirejs/text for details
 */

/*!
 * jQuery blockUI plugin
 * Version 2.66.0-2013.10.09
 * Requires jQuery v1.7 or later
 *
 * Examples at: http://malsup.com/jquery/block/
 * Copyright (c) 2007-2013 M. Alsup
 * Dual licensed under the MIT and GPL licenses:
 * http://www.opensource.org/licenses/mit-license.php
 * http://www.gnu.org/licenses/gpl.html
 *
 * Thanks to Amir-Hossein Sobhi for some excellent contributions!
 */

/*
 * Inline Form Validation Engine 2.6.2, jQuery plugin
 *
 * Copyright(c) 2010, Cedric Dugas
 * http://www.position-absolute.com
 *
 * 2.0 Rewrite by Olivier Refalo
 * http://www.crionics.com
 *
 * Form validation engine allowing custom regex rules to be added.
 * Licensed under the MIT License
 */

!function(a, b) {
    "object" == typeof module && "object" == typeof module.exports ? module.exports = a.document ? b(a, !0) : function(a) {
        if (!a.document) throw new Error("jQuery requires a window with a document");
        return b(a);
    } : b(a);
}("undefined" != typeof window ? window : this, function(a, b) {
    var c = [], d = c.slice, e = c.concat, f = c.push, g = c.indexOf, h = {}, i = h.toString, j = h.hasOwnProperty, k = {}, l = "1.11.1", m = function(a, b) {
        return new m.fn.init(a, b);
    }, n = /^[\s\uFEFF\xA0]+|[\s\uFEFF\xA0]+$/g, o = /^-ms-/, p = /-([\da-z])/gi, q = function(a, b) {
        return b.toUpperCase();
    };
    m.fn = m.prototype = {
        jquery: l,
        constructor: m,
        selector: "",
        length: 0,
        toArray: function() {
            return d.call(this);
        },
        get: function(a) {
            return null != a ? 0 > a ? this[a + this.length] : this[a] : d.call(this);
        },
        pushStack: function(
a) {
            var b = m.merge(this.constructor(), a);
            return b.prevObject = this, b.context = this.context, b;
        },
        each: function(a, b) {
            return m.each(this, a, b);
        },
        map: function(a) {
            return this.pushStack(m.map(this, function(b, c) {
                return a.call(b, c, b);
            }));
        },
        slice: function() {
            return this.pushStack(d.apply(this, arguments));
        },
        first: function() {
            return this.eq(0);
        },
        last: function() {
            return this.eq(-1);
        },
        eq: function(a) {
            var b = this.length, c = +a + (0 > a ? b : 0);
            return this.pushStack(c >= 0 && b > c ? [ this[c] ] : []);
        },
        end: function() {
            return this.prevObject || this.constructor(null);
        },
        push: f,
        sort: c.sort,
        splice: c.splice
    }, m.extend = m.fn.extend = function() {
        var a
, b, c, d, e, f, g = arguments[0] || {}, h = 1, i = arguments.length, j = !1;
        for ("boolean" == typeof g && (j = g, g = arguments[h] || {}, h++), "object" == typeof g || m.isFunction(g) || (g = {}), h === i && (g = this, h--); i > h; h++) if (null != (e = arguments[h])) for (d in e) a = g[d], c = e[d], g !== c && (j && c && (m.isPlainObject(c) || (b = m.isArray(c))) ? (b ? (b = !1, f = a && m.isArray(a) ? a : []) : f = a && m.isPlainObject(a) ? a : {}, g[d] = m.extend(j, f, c)) : void 0 !== c && (g[d] = c));
        return g;
    }, m.extend({
        expando: "jQuery" + (l + Math.random()).replace(/\D/g, ""),
        isReady: !0,
        error: function(a) {
            throw new Error(a);
        },
        noop: function() {},
        isFunction: function(a) {
            return "function" === m.type(a);
        },
        isArray: Array.isArray || function(a) {
            return "array" === m.type(a);
        },
        isWindow: function(a) {
            return null != a && 
a == a.window;
        },
        isNumeric: function(a) {
            return !m.isArray(a) && a - parseFloat(a) >= 0;
        },
        isEmptyObject: function(a) {
            var b;
            for (b in a) return !1;
            return !0;
        },
        isPlainObject: function(a) {
            var b;
            if (!a || "object" !== m.type(a) || a.nodeType || m.isWindow(a)) return !1;
            try {
                if (a.constructor && !j.call(a, "constructor") && !j.call(a.constructor.prototype, "isPrototypeOf")) return !1;
            } catch (c) {
                return !1;
            }
            if (k.ownLast) for (b in a) return j.call(a, b);
            for (b in a) ;
            return void 0 === b || j.call(a, b);
        },
        type: function(a) {
            return null == a ? a + "" : "object" == typeof a || "function" == typeof a ? h[i.call(a)] || "object" : typeof a;
        },
        globalEval: function(b) {
            b && m.trim(b) && (a.execScript || 
function(b) {
                a.eval.call(a, b);
            })(b);
        },
        camelCase: function(a) {
            return a.replace(o, "ms-").replace(p, q);
        },
        nodeName: function(a, b) {
            return a.nodeName && a.nodeName.toLowerCase() === b.toLowerCase();
        },
        each: function(a, b, c) {
            var d, e = 0, f = a.length, g = r(a);
            if (c) {
                if (g) {
                    for (; f > e; e++) if (d = b.apply(a[e], c), d === !1) break;
                } else for (e in a) if (d = b.apply(a[e], c), d === !1) break;
            } else if (g) {
                for (; f > e; e++) if (d = b.call(a[e], e, a[e]), d === !1) break;
            } else for (e in a) if (d = b.call(a[e], e, a[e]), d === !1) break;
            return a;
        },
        trim: function(a) {
            return null == a ? "" : (a + "").replace(n, "");
        },
        makeArray: function(a, b) {
            var c = b || [];
            return null != 
a && (r(Object(a)) ? m.merge(c, "string" == typeof a ? [ a ] : a) : f.call(c, a)), c;
        },
        inArray: function(a, b, c) {
            var d;
            if (b) {
                if (g) return g.call(b, a, c);
                for (d = b.length, c = c ? 0 > c ? Math.max(0, d + c) : c : 0; d > c; c++) if (c in b && b[c] === a) return c;
            }
            return -1;
        },
        merge: function(a, b) {
            var c = +b.length, d = 0, e = a.length;
            while (c > d) a[e++] = b[d++];
            if (c !== c) while (void 0 !== b[d]) a[e++] = b[d++];
            return a.length = e, a;
        },
        grep: function(a, b, c) {
            for (var d, e = [], f = 0, g = a.length, h = !c; g > f; f++) d = !b(a[f], f), d !== h && e.push(a[f]);
            return e;
        },
        map: function(a, b, c) {
            var d, f = 0, g = a.length, h = r(a), i = [];
            if (h) for (; g > f; f++) d = b(a[f], f, c), null != d && i.push(d); else for (f in 
a) d = b(a[f], f, c), null != d && i.push(d);
            return e.apply([], i);
        },
        guid: 1,
        proxy: function(a, b) {
            var c, e, f;
            return "string" == typeof b && (f = a[b], b = a, a = f), m.isFunction(a) ? (c = d.call(arguments, 2), e = function() {
                return a.apply(b || this, c.concat(d.call(arguments)));
            }, e.guid = a.guid = a.guid || m.guid++, e) : void 0;
        },
        now: function() {
            return +(new Date);
        },
        support: k
    }), m.each("Boolean Number String Function Array Date RegExp Object Error".split(" "), function(a, b) {
        h["[object " + b + "]"] = b.toLowerCase();
    });
    function r(a) {
        var b = a.length, c = m.type(a);
        return "function" === c || m.isWindow(a) ? !1 : 1 === a.nodeType && b ? !0 : "array" === c || 0 === b || "number" == typeof b && b > 0 && b - 1 in a;
    }
    var s = function(a) {
        var b, c, d, e, f, g, h, i, j, k, l, m, n
, o, p, q, r, s, t, u = "sizzle" + -(new Date), v = a.document, w = 0, x = 0, y = gb(), z = gb(), A = gb(), B = function(a, b) {
            return a === b && (l = !0), 0;
        }, C = "undefined", D = 1 << 31, E = {}.hasOwnProperty, F = [], G = F.pop, H = F.push, I = F.push, J = F.slice, K = F.indexOf || function(a) {
            for (var b = 0, c = this.length; c > b; b++) if (this[b] === a) return b;
            return -1;
        }, L = "checked|selected|async|autofocus|autoplay|controls|defer|disabled|hidden|ismap|loop|multiple|open|readonly|required|scoped", M = "[\\x20\\t\\r\\n\\f]", N = "(?:\\\\.|[\\w-]|[^\\x00-\\xa0])+", O = N.replace("w", "w#"), P = "\\[" + M + "*(" + N + ")(?:" + M + "*([*^$|!~]?=)" + M + "*(?:'((?:\\\\.|[^\\\\'])*)'|\"((?:\\\\.|[^\\\\\"])*)\"|(" + O + "))|)" + M + "*\\]", Q = ":(" + N + ")(?:\\((('((?:\\\\.|[^\\\\'])*)'|\"((?:\\\\.|[^\\\\\"])*)\")|((?:\\\\.|[^\\\\()[\\]]|" + P + ")*)|.*)\\)|)", R = new RegExp("^" + M + "+|((?:^|[^\\\\])(?:\\\\.)*)" + M + "+$"
, "g"), S = new RegExp("^" + M + "*," + M + "*"), T = new RegExp("^" + M + "*([>+~]|" + M + ")" + M + "*"), U = new RegExp("=" + M + "*([^\\]'\"]*?)" + M + "*\\]", "g"), V = new RegExp(Q), W = new RegExp("^" + O + "$"), X = {
            ID: new RegExp("^#(" + N + ")"),
            CLASS: new RegExp("^\\.(" + N + ")"),
            TAG: new RegExp("^(" + N.replace("w", "w*") + ")"),
            ATTR: new RegExp("^" + P),
            PSEUDO: new RegExp("^" + Q),
            CHILD: new RegExp("^:(only|first|last|nth|nth-last)-(child|of-type)(?:\\(" + M + "*(even|odd|(([+-]|)(\\d*)n|)" + M + "*(?:([+-]|)" + M + "*(\\d+)|))" + M + "*\\)|)", "i"),
            bool: new RegExp("^(?:" + L + ")$", "i"),
            needsContext: new RegExp("^" + M + "*[>+~]|:(even|odd|eq|gt|lt|nth|first|last)(?:\\(" + M + "*((?:-\\d)?\\d*)" + M + "*\\)|)(?=[^-]|$)", "i")
        }, Y = /^(?:input|select|textarea|button)$/i, Z = /^h\d$/i, $ = /^[^{]+\{\s*\[native \w/, _ = /^(?:#([\w-]+)|(\w+)|\.([\w-]+))$/, ab = /[+~]/
, bb = /'|\\/g, cb = new RegExp("\\\\([\\da-f]{1,6}" + M + "?|(" + M + ")|.)", "ig"), db = function(a, b, c) {
            var d = "0x" + b - 65536;
            return d !== d || c ? b : 0 > d ? String.fromCharCode(d + 65536) : String.fromCharCode(d >> 10 | 55296, 1023 & d | 56320);
        };
        try {
            I.apply(F = J.call(v.childNodes), v.childNodes), F[v.childNodes.length].nodeType;
        } catch (eb) {
            I = {
                apply: F.length ? function(a, b) {
                    H.apply(a, J.call(b));
                } : function(a, b) {
                    var c = a.length, d = 0;
                    while (a[c++] = b[d++]) ;
                    a.length = c - 1;
                }
            };
        }
        function fb(a, b, d, e) {
            var f, h, j, k, l, o, r, s, w, x;
            if ((b ? b.ownerDocument || b : v) !== n && m(b), b = b || n, d = d || [], !a || "string" != typeof a) return d;
            if (1 !== (k = b.nodeType) && 9 !== k
) return [];
            if (p && !e) {
                if (f = _.exec(a)) if (j = f[1]) {
                    if (9 === k) {
                        if (h = b.getElementById(j), !h || !h.parentNode) return d;
                        if (h.id === j) return d.push(h), d;
                    } else if (b.ownerDocument && (h = b.ownerDocument.getElementById(j)) && t(b, h) && h.id === j) return d.push(h), d;
                } else {
                    if (f[2]) return I.apply(d, b.getElementsByTagName(a)), d;
                    if ((j = f[3]) && c.getElementsByClassName && b.getElementsByClassName) return I.apply(d, b.getElementsByClassName(j)), d;
                }
                if (c.qsa && (!q || !q.test(a))) {
                    if (s = r = u, w = b, x = 9 === k && a, 1 === k && "object" !== b.nodeName.toLowerCase()) {
                        o = g(a), (r = b.getAttribute("id")) ? s = r.replace(bb, "\\$&") : b.setAttribute("id", s), s = "[id='" + s + "'] ", l = o.length;
                        
while (l--) o[l] = s + qb(o[l]);
                        w = ab.test(a) && ob(b.parentNode) || b, x = o.join(",");
                    }
                    if (x) try {
                        return I.apply(d, w.querySelectorAll(x)), d;
                    } catch (y) {} finally {
                        r || b.removeAttribute("id");
                    }
                }
            }
            return i(a.replace(R, "$1"), b, d, e);
        }
        function gb() {
            var a = [];
            function b(c, e) {
                return a.push(c + " ") > d.cacheLength && delete b[a.shift()], b[c + " "] = e;
            }
            return b;
        }
        function hb(a) {
            return a[u] = !0, a;
        }
        function ib(a) {
            var b = n.createElement("div");
            try {
                return !!a(b);
            } catch (c) {
                return !1;
            } finally {
                b.parentNode && b.parentNode.removeChild(b), b = 
null;
            }
        }
        function jb(a, b) {
            var c = a.split("|"), e = a.length;
            while (e--) d.attrHandle[c[e]] = b;
        }
        function kb(a, b) {
            var c = b && a, d = c && 1 === a.nodeType && 1 === b.nodeType && (~b.sourceIndex || D) - (~a.sourceIndex || D);
            if (d) return d;
            if (c) while (c = c.nextSibling) if (c === b) return -1;
            return a ? 1 : -1;
        }
        function lb(a) {
            return function(b) {
                var c = b.nodeName.toLowerCase();
                return "input" === c && b.type === a;
            };
        }
        function mb(a) {
            return function(b) {
                var c = b.nodeName.toLowerCase();
                return ("input" === c || "button" === c) && b.type === a;
            };
        }
        function nb(a) {
            return hb(function(b) {
                return b = +b, hb(function(c, d) {
                    var e, f = a([], c.length
, b), g = f.length;
                    while (g--) c[e = f[g]] && (c[e] = !(d[e] = c[e]));
                });
            });
        }
        function ob(a) {
            return a && typeof a.getElementsByTagName !== C && a;
        }
        c = fb.support = {}, f = fb.isXML = function(a) {
            var b = a && (a.ownerDocument || a).documentElement;
            return b ? "HTML" !== b.nodeName : !1;
        }, m = fb.setDocument = function(a) {
            var b, e = a ? a.ownerDocument || a : v, g = e.defaultView;
            return e !== n && 9 === e.nodeType && e.documentElement ? (n = e, o = e.documentElement, p = !f(e), g && g !== g.top && (g.addEventListener ? g.addEventListener("unload", function() {
                m();
            }, !1) : g.attachEvent && g.attachEvent("onunload", function() {
                m();
            })), c.attributes = ib(function(a) {
                return a.className = "i", !a.getAttribute("className");
            }), c.getElementsByTagName = 
ib(function(a) {
                return a.appendChild(e.createComment("")), !a.getElementsByTagName("*").length;
            }), c.getElementsByClassName = $.test(e.getElementsByClassName) && ib(function(a) {
                return a.innerHTML = "<div class='a'></div><div class='a i'></div>", a.firstChild.className = "i", 2 === a.getElementsByClassName("i").length;
            }), c.getById = ib(function(a) {
                return o.appendChild(a).id = u, !e.getElementsByName || !e.getElementsByName(u).length;
            }), c.getById ? (d.find.ID = function(a, b) {
                if (typeof b.getElementById !== C && p) {
                    var c = b.getElementById(a);
                    return c && c.parentNode ? [ c ] : [];
                }
            }, d.filter.ID = function(a) {
                var b = a.replace(cb, db);
                return function(a) {
                    return a.getAttribute("id") === b;
                };
            }) : (delete d.find.ID, d.filter.
ID = function(a) {
                var b = a.replace(cb, db);
                return function(a) {
                    var c = typeof a.getAttributeNode !== C && a.getAttributeNode("id");
                    return c && c.value === b;
                };
            }), d.find.TAG = c.getElementsByTagName ? function(a, b) {
                return typeof b.getElementsByTagName !== C ? b.getElementsByTagName(a) : void 0;
            } : function(a, b) {
                var c, d = [], e = 0, f = b.getElementsByTagName(a);
                if ("*" === a) {
                    while (c = f[e++]) 1 === c.nodeType && d.push(c);
                    return d;
                }
                return f;
            }, d.find.CLASS = c.getElementsByClassName && function(a, b) {
                return typeof b.getElementsByClassName !== C && p ? b.getElementsByClassName(a) : void 0;
            }, r = [], q = [], (c.qsa = $.test(e.querySelectorAll)) && (ib(function(a) {
                a.innerHTML = "<select msallowclip=''><option selected=''></option></select>"
, a.querySelectorAll("[msallowclip^='']").length && q.push("[*^$]=" + M + "*(?:''|\"\")"), a.querySelectorAll("[selected]").length || q.push("\\[" + M + "*(?:value|" + L + ")"), a.querySelectorAll(":checked").length || q.push(":checked");
            }), ib(function(a) {
                var b = e.createElement("input");
                b.setAttribute("type", "hidden"), a.appendChild(b).setAttribute("name", "D"), a.querySelectorAll("[name=d]").length && q.push("name" + M + "*[*^$|!~]?="), a.querySelectorAll(":enabled").length || q.push(":enabled", ":disabled"), a.querySelectorAll("*,:x"), q.push(",.*:");
            })), (c.matchesSelector = $.test(s = o.matches || o.webkitMatchesSelector || o.mozMatchesSelector || o.oMatchesSelector || o.msMatchesSelector)) && ib(function(a) {
                c.disconnectedMatch = s.call(a, "div"), s.call(a, "[s!='']:x"), r.push("!=", Q);
            }), q = q.length && new RegExp(q.join("|")), r = r.length && new RegExp(r.join("|")), b = $.test(o.compareDocumentPosition
), t = b || $.test(o.contains) ? function(a, b) {
                var c = 9 === a.nodeType ? a.documentElement : a, d = b && b.parentNode;
                return a === d || !!d && 1 === d.nodeType && !!(c.contains ? c.contains(d) : a.compareDocumentPosition && 16 & a.compareDocumentPosition(d));
            } : function(a, b) {
                if (b) while (b = b.parentNode) if (b === a) return !0;
                return !1;
            }, B = b ? function(a, b) {
                if (a === b) return l = !0, 0;
                var d = !a.compareDocumentPosition - !b.compareDocumentPosition;
                return d ? d : (d = (a.ownerDocument || a) === (b.ownerDocument || b) ? a.compareDocumentPosition(b) : 1, 1 & d || !c.sortDetached && b.compareDocumentPosition(a) === d ? a === e || a.ownerDocument === v && t(v, a) ? -1 : b === e || b.ownerDocument === v && t(v, b) ? 1 : k ? K.call(k, a) - K.call(k, b) : 0 : 4 & d ? -1 : 1);
            } : function(a, b) {
                if (a === b) 
return l = !0, 0;
                var c, d = 0, f = a.parentNode, g = b.parentNode, h = [ a ], i = [ b ];
                if (!f || !g) return a === e ? -1 : b === e ? 1 : f ? -1 : g ? 1 : k ? K.call(k, a) - K.call(k, b) : 0;
                if (f === g) return kb(a, b);
                c = a;
                while (c = c.parentNode) h.unshift(c);
                c = b;
                while (c = c.parentNode) i.unshift(c);
                while (h[d] === i[d]) d++;
                return d ? kb(h[d], i[d]) : h[d] === v ? -1 : i[d] === v ? 1 : 0;
            }, e) : n;
        }, fb.matches = function(a, b) {
            return fb(a, null, null, b);
        }, fb.matchesSelector = function(a, b) {
            if ((a.ownerDocument || a) !== n && m(a), b = b.replace(U, "='$1']"), !(!c.matchesSelector || !p || r && r.test(b) || q && q.test(b))) try {
                var d = s.call(a, b);
                if (d || c.disconnectedMatch || a.document && 11 !== a.document.nodeType) return d;
            
} catch (e) {}
            return fb(b, n, null, [ a ]).length > 0;
        }, fb.contains = function(a, b) {
            return (a.ownerDocument || a) !== n && m(a), t(a, b);
        }, fb.attr = function(a, b) {
            (a.ownerDocument || a) !== n && m(a);
            var e = d.attrHandle[b.toLowerCase()], f = e && E.call(d.attrHandle, b.toLowerCase()) ? e(a, b, !p) : void 0;
            return void 0 !== f ? f : c.attributes || !p ? a.getAttribute(b) : (f = a.getAttributeNode(b)) && f.specified ? f.value : null;
        }, fb.error = function(a) {
            throw new Error("Syntax error, unrecognized expression: " + a);
        }, fb.uniqueSort = function(a) {
            var b, d = [], e = 0, f = 0;
            if (l = !c.detectDuplicates, k = !c.sortStable && a.slice(0), a.sort(B), l) {
                while (b = a[f++]) b === a[f] && (e = d.push(f));
                while (e--) a.splice(d[e], 1);
            }
            return k = null, a;
        }, e = fb.getText = function(
a) {
            var b, c = "", d = 0, f = a.nodeType;
            if (f) {
                if (1 === f || 9 === f || 11 === f) {
                    if ("string" == typeof a.textContent) return a.textContent;
                    for (a = a.firstChild; a; a = a.nextSibling) c += e(a);
                } else if (3 === f || 4 === f) return a.nodeValue;
            } else while (b = a[d++]) c += e(b);
            return c;
        }, d = fb.selectors = {
            cacheLength: 50,
            createPseudo: hb,
            match: X,
            attrHandle: {},
            find: {},
            relative: {
                ">": {
                    dir: "parentNode",
                    first: !0
                },
                " ": {
                    dir: "parentNode"
                },
                "+": {
                    dir: "previousSibling",
                    first: !0
                },
                "~": {
                    dir: "previousSibling"
                }
            
},
            preFilter: {
                ATTR: function(a) {
                    return a[1] = a[1].replace(cb, db), a[3] = (a[3] || a[4] || a[5] || "").replace(cb, db), "~=" === a[2] && (a[3] = " " + a[3] + " "), a.slice(0, 4);
                },
                CHILD: function(a) {
                    return a[1] = a[1].toLowerCase(), "nth" === a[1].slice(0, 3) ? (a[3] || fb.error(a[0]), a[4] = +(a[4] ? a[5] + (a[6] || 1) : 2 * ("even" === a[3] || "odd" === a[3])), a[5] = +(a[7] + a[8] || "odd" === a[3])) : a[3] && fb.error(a[0]), a;
                },
                PSEUDO: function(a) {
                    var b, c = !a[6] && a[2];
                    return X.CHILD.test(a[0]) ? null : (a[3] ? a[2] = a[4] || a[5] || "" : c && V.test(c) && (b = g(c, !0)) && (b = c.indexOf(")", c.length - b) - c.length) && (a[0] = a[0].slice(0, b), a[2] = c.slice(0, b)), a.slice(0, 3));
                }
            },
            filter: {
                TAG: function(a) {
                    var b = 
a.replace(cb, db).toLowerCase();
                    return "*" === a ? function() {
                        return !0;
                    } : function(a) {
                        return a.nodeName && a.nodeName.toLowerCase() === b;
                    };
                },
                CLASS: function(a) {
                    var b = y[a + " "];
                    return b || (b = new RegExp("(^|" + M + ")" + a + "(" + M + "|$)")) && y(a, function(a) {
                        return b.test("string" == typeof a.className && a.className || typeof a.getAttribute !== C && a.getAttribute("class") || "");
                    });
                },
                ATTR: function(a, b, c) {
                    return function(d) {
                        var e = fb.attr(d, a);
                        return null == e ? "!=" === b : b ? (e += "", "=" === b ? e === c : "!=" === b ? e !== c : "^=" === b ? c && 0 === e.indexOf(c) : "*=" === b ? c && e.indexOf(c) > -1 : "$=" === b ? c && e.slice
(-c.length) === c : "~=" === b ? (" " + e + " ").indexOf(c) > -1 : "|=" === b ? e === c || e.slice(0, c.length + 1) === c + "-" : !1) : !0;
                    };
                },
                CHILD: function(a, b, c, d, e) {
                    var f = "nth" !== a.slice(0, 3), g = "last" !== a.slice(-4), h = "of-type" === b;
                    return 1 === d && 0 === e ? function(a) {
                        return !!a.parentNode;
                    } : function(b, c, i) {
                        var j, k, l, m, n, o, p = f !== g ? "nextSibling" : "previousSibling", q = b.parentNode, r = h && b.nodeName.toLowerCase(), s = !i && !h;
                        if (q) {
                            if (f) {
                                while (p) {
                                    l = b;
                                    while (l = l[p]) if (h ? l.nodeName.toLowerCase() === r : 1 === l.nodeType) return !1;
                                    o = p = "only" === a && !o && "nextSibling"
;
                                }
                                return !0;
                            }
                            if (o = [ g ? q.firstChild : q.lastChild ], g && s) {
                                k = q[u] || (q[u] = {}), j = k[a] || [], n = j[0] === w && j[1], m = j[0] === w && j[2], l = n && q.childNodes[n];
                                while (l = ++n && l && l[p] || (m = n = 0) || o.pop()) if (1 === l.nodeType && ++m && l === b) {
                                    k[a] = [ w, n, m ];
                                    break;
                                }
                            } else if (s && (j = (b[u] || (b[u] = {}))[a]) && j[0] === w) m = j[1]; else while (l = ++n && l && l[p] || (m = n = 0) || o.pop()) if ((h ? l.nodeName.toLowerCase() === r : 1 === l.nodeType) && ++m && (s && ((l[u] || (l[u] = {}))[a] = [ w, m ]), l === b)) break;
                            return m -= e, m === d || m % d === 0 && m / d >= 0;
                        }
                    
};
                },
                PSEUDO: function(a, b) {
                    var c, e = d.pseudos[a] || d.setFilters[a.toLowerCase()] || fb.error("unsupported pseudo: " + a);
                    return e[u] ? e(b) : e.length > 1 ? (c = [ a, a, "", b ], d.setFilters.hasOwnProperty(a.toLowerCase()) ? hb(function(a, c) {
                        var d, f = e(a, b), g = f.length;
                        while (g--) d = K.call(a, f[g]), a[d] = !(c[d] = f[g]);
                    }) : function(a) {
                        return e(a, 0, c);
                    }) : e;
                }
            },
            pseudos: {
                not: hb(function(a) {
                    var b = [], c = [], d = h(a.replace(R, "$1"));
                    return d[u] ? hb(function(a, b, c, e) {
                        var f, g = d(a, null, e, []), h = a.length;
                        while (h--) (f = g[h]) && (a[h] = !(b[h] = f));
                    }) : function(a, e, f) {
                        
return b[0] = a, d(b, null, f, c), !c.pop();
                    };
                }),
                has: hb(function(a) {
                    return function(b) {
                        return fb(a, b).length > 0;
                    };
                }),
                contains: hb(function(a) {
                    return function(b) {
                        return (b.textContent || b.innerText || e(b)).indexOf(a) > -1;
                    };
                }),
                lang: hb(function(a) {
                    return W.test(a || "") || fb.error("unsupported lang: " + a), a = a.replace(cb, db).toLowerCase(), function(b) {
                        var c;
                        do if (c = p ? b.lang : b.getAttribute("xml:lang") || b.getAttribute("lang")) return c = c.toLowerCase(), c === a || 0 === c.indexOf(a + "-"); while ((b = b.parentNode) && 1 === b.nodeType);
                        return !1;
                    };
                }),
                target: function(
b) {
                    var c = a.location && a.location.hash;
                    return c && c.slice(1) === b.id;
                },
                root: function(a) {
                    return a === o;
                },
                focus: function(a) {
                    return a === n.activeElement && (!n.hasFocus || n.hasFocus()) && !!(a.type || a.href || ~a.tabIndex);
                },
                enabled: function(a) {
                    return a.disabled === !1;
                },
                disabled: function(a) {
                    return a.disabled === !0;
                },
                checked: function(a) {
                    var b = a.nodeName.toLowerCase();
                    return "input" === b && !!a.checked || "option" === b && !!a.selected;
                },
                selected: function(a) {
                    return a.parentNode && a.parentNode.selectedIndex, a.selected === !0;
                },
                empty: function(a) 
{
                    for (a = a.firstChild; a; a = a.nextSibling) if (a.nodeType < 6) return !1;
                    return !0;
                },
                parent: function(a) {
                    return !d.pseudos.empty(a);
                },
                header: function(a) {
                    return Z.test(a.nodeName);
                },
                input: function(a) {
                    return Y.test(a.nodeName);
                },
                button: function(a) {
                    var b = a.nodeName.toLowerCase();
                    return "input" === b && "button" === a.type || "button" === b;
                },
                text: function(a) {
                    var b;
                    return "input" === a.nodeName.toLowerCase() && "text" === a.type && (null == (b = a.getAttribute("type")) || "text" === b.toLowerCase());
                },
                first: nb(function() {
                    return [ 0 ];
                }),
                
last: nb(function(a, b) {
                    return [ b - 1 ];
                }),
                eq: nb(function(a, b, c) {
                    return [ 0 > c ? c + b : c ];
                }),
                even: nb(function(a, b) {
                    for (var c = 0; b > c; c += 2) a.push(c);
                    return a;
                }),
                odd: nb(function(a, b) {
                    for (var c = 1; b > c; c += 2) a.push(c);
                    return a;
                }),
                lt: nb(function(a, b, c) {
                    for (var d = 0 > c ? c + b : c; --d >= 0; ) a.push(d);
                    return a;
                }),
                gt: nb(function(a, b, c) {
                    for (var d = 0 > c ? c + b : c; ++d < b; ) a.push(d);
                    return a;
                })
            }
        }, d.pseudos.nth = d.pseudos.eq;
        for (b in {
            radio: !0,
            checkbox: !0,
            file: !0,
            password
: !0,
            image: !0
        }) d.pseudos[b] = lb(b);
        for (b in {
            submit: !0,
            reset: !0
        }) d.pseudos[b] = mb(b);
        function pb() {}
        pb.prototype = d.filters = d.pseudos, d.setFilters = new pb, g = fb.tokenize = function(a, b) {
            var c, e, f, g, h, i, j, k = z[a + " "];
            if (k) return b ? 0 : k.slice(0);
            h = a, i = [], j = d.preFilter;
            while (h) {
                (!c || (e = S.exec(h))) && (e && (h = h.slice(e[0].length) || h), i.push(f = [])), c = !1, (e = T.exec(h)) && (c = e.shift(), f.push({
                    value: c,
                    type: e[0].replace(R, " ")
                }), h = h.slice(c.length));
                for (g in d.filter) !(e = X[g].exec(h)) || j[g] && !(e = j[g](e)) || (c = e.shift(), f.push({
                    value: c,
                    type: g,
                    matches: e
                }), h = h.slice(c.length));
                if (!c) break;
            
}
            return b ? h.length : h ? fb.error(a) : z(a, i).slice(0);
        };
        function qb(a) {
            for (var b = 0, c = a.length, d = ""; c > b; b++) d += a[b].value;
            return d;
        }
        function rb(a, b, c) {
            var d = b.dir, e = c && "parentNode" === d, f = x++;
            return b.first ? function(b, c, f) {
                while (b = b[d]) if (1 === b.nodeType || e) return a(b, c, f);
            } : function(b, c, g) {
                var h, i, j = [ w, f ];
                if (g) {
                    while (b = b[d]) if ((1 === b.nodeType || e) && a(b, c, g)) return !0;
                } else while (b = b[d]) if (1 === b.nodeType || e) {
                    if (i = b[u] || (b[u] = {}), (h = i[d]) && h[0] === w && h[1] === f) return j[2] = h[2];
                    if (i[d] = j, j[2] = a(b, c, g)) return !0;
                }
            };
        }
        function sb(a) {
            return a.length > 1 ? function(b, c, d) {
                
var e = a.length;
                while (e--) if (!a[e](b, c, d)) return !1;
                return !0;
            } : a[0];
        }
        function tb(a, b, c) {
            for (var d = 0, e = b.length; e > d; d++) fb(a, b[d], c);
            return c;
        }
        function ub(a, b, c, d, e) {
            for (var f, g = [], h = 0, i = a.length, j = null != b; i > h; h++) (f = a[h]) && (!c || c(f, d, e)) && (g.push(f), j && b.push(h));
            return g;
        }
        function vb(a, b, c, d, e, f) {
            return d && !d[u] && (d = vb(d)), e && !e[u] && (e = vb(e, f)), hb(function(f, g, h, i) {
                var j, k, l, m = [], n = [], o = g.length, p = f || tb(b || "*", h.nodeType ? [ h ] : h, []), q = !a || !f && b ? p : ub(p, m, a, h, i), r = c ? e || (f ? a : o || d) ? [] : g : q;
                if (c && c(q, r, h, i), d) {
                    j = ub(r, n), d(j, [], h, i), k = j.length;
                    while (k--) (l = j[k]) && (r[n[k]] = !(q[n[k]] = l
));
                }
                if (f) {
                    if (e || a) {
                        if (e) {
                            j = [], k = r.length;
                            while (k--) (l = r[k]) && j.push(q[k] = l);
                            e(null, r = [], j, i);
                        }
                        k = r.length;
                        while (k--) (l = r[k]) && (j = e ? K.call(f, l) : m[k]) > -1 && (f[j] = !(g[j] = l));
                    }
                } else r = ub(r === g ? r.splice(o, r.length) : r), e ? e(null, g, r, i) : I.apply(g, r);
            });
        }
        function wb(a) {
            for (var b, c, e, f = a.length, g = d.relative[a[0].type], h = g || d.relative[" "], i = g ? 1 : 0, k = rb(function(a) {
                return a === b;
            }, h, !0), l = rb(function(a) {
                return K.call(b, a) > -1;
            }, h, !0), m = [ function(a, c, d) {
                return !g && (d || c !== j) || ((b = c).nodeType ? 
k(a, c, d) : l(a, c, d));
            } ]; f > i; i++) if (c = d.relative[a[i].type]) m = [ rb(sb(m), c) ]; else {
                if (c = d.filter[a[i].type].apply(null, a[i].matches), c[u]) {
                    for (e = ++i; f > e; e++) if (d.relative[a[e].type]) break;
                    return vb(i > 1 && sb(m), i > 1 && qb(a.slice(0, i - 1).concat({
                        value: " " === a[i - 2].type ? "*" : ""
                    })).replace(R, "$1"), c, e > i && wb(a.slice(i, e)), f > e && wb(a = a.slice(e)), f > e && qb(a));
                }
                m.push(c);
            }
            return sb(m);
        }
        function xb(a, b) {
            var c = b.length > 0, e = a.length > 0, f = function(f, g, h, i, k) {
                var l, m, o, p = 0, q = "0", r = f && [], s = [], t = j, u = f || e && d.find.TAG("*", k), v = w += null == t ? 1 : Math.random() || .1, x = u.length;
                for (k && (j = g !== n && g); q !== x && null != (l = u[q]); q++) {
                    
if (e && l) {
                        m = 0;
                        while (o = a[m++]) if (o(l, g, h)) {
                            i.push(l);
                            break;
                        }
                        k && (w = v);
                    }
                    c && ((l = !o && l) && p--, f && r.push(l));
                }
                if (p += q, c && q !== p) {
                    m = 0;
                    while (o = b[m++]) o(r, s, g, h);
                    if (f) {
                        if (p > 0) while (q--) r[q] || s[q] || (s[q] = G.call(i));
                        s = ub(s);
                    }
                    I.apply(i, s), k && !f && s.length > 0 && p + b.length > 1 && fb.uniqueSort(i);
                }
                return k && (w = v, j = t), r;
            };
            return c ? hb(f) : f;
        }
        return h = fb.compile = function(a, b) {
            var c, d = [], e = [], f = A[a + " "];
            if (!f) {
                
b || (b = g(a)), c = b.length;
                while (c--) f = wb(b[c]), f[u] ? d.push(f) : e.push(f);
                f = A(a, xb(e, d)), f.selector = a;
            }
            return f;
        }, i = fb.select = function(a, b, e, f) {
            var i, j, k, l, m, n = "function" == typeof a && a, o = !f && g(a = n.selector || a);
            if (e = e || [], 1 === o.length) {
                if (j = o[0] = o[0].slice(0), j.length > 2 && "ID" === (k = j[0]).type && c.getById && 9 === b.nodeType && p && d.relative[j[1].type]) {
                    if (b = (d.find.ID(k.matches[0].replace(cb, db), b) || [])[0], !b) return e;
                    n && (b = b.parentNode), a = a.slice(j.shift().value.length);
                }
                i = X.needsContext.test(a) ? 0 : j.length;
                while (i--) {
                    if (k = j[i], d.relative[l = k.type]) break;
                    if ((m = d.find[l]) && (f = m(k.matches[0].replace(cb, db), ab.test(j[0].type) && ob(b.parentNode
) || b))) {
                        if (j.splice(i, 1), a = f.length && qb(j), !a) return I.apply(e, f), e;
                        break;
                    }
                }
            }
            return (n || h(a, o))(f, b, !p, e, ab.test(a) && ob(b.parentNode) || b), e;
        }, c.sortStable = u.split("").sort(B).join("") === u, c.detectDuplicates = !!l, m(), c.sortDetached = ib(function(a) {
            return 1 & a.compareDocumentPosition(n.createElement("div"));
        }), ib(function(a) {
            return a.innerHTML = "<a href='#'></a>", "#" === a.firstChild.getAttribute("href");
        }) || jb("type|href|height|width", function(a, b, c) {
            return c ? void 0 : a.getAttribute(b, "type" === b.toLowerCase() ? 1 : 2);
        }), c.attributes && ib(function(a) {
            return a.innerHTML = "<input/>", a.firstChild.setAttribute("value", ""), "" === a.firstChild.getAttribute("value");
        }) || jb("value", function(a, b, c) {
            return c || "input" !== 
a.nodeName.toLowerCase() ? void 0 : a.defaultValue;
        }), ib(function(a) {
            return null == a.getAttribute("disabled");
        }) || jb(L, function(a, b, c) {
            var d;
            return c ? void 0 : a[b] === !0 ? b.toLowerCase() : (d = a.getAttributeNode(b)) && d.specified ? d.value : null;
        }), fb;
    }(a);
    m.find = s, m.expr = s.selectors, m.expr[":"] = m.expr.pseudos, m.unique = s.uniqueSort, m.text = s.getText, m.isXMLDoc = s.isXML, m.contains = s.contains;
    var t = m.expr.match.needsContext, u = /^<(\w+)\s*\/?>(?:<\/\1>|)$/, v = /^.[^:#\[\.,]*$/;
    function w(a, b, c) {
        if (m.isFunction(b)) return m.grep(a, function(a, d) {
            return !!b.call(a, d, a) !== c;
        });
        if (b.nodeType) return m.grep(a, function(a) {
            return a === b !== c;
        });
        if ("string" == typeof b) {
            if (v.test(b)) return m.filter(b, a, c);
            b = m.filter(b, a);
        }
        return m.grep(a
, function(a) {
            return m.inArray(a, b) >= 0 !== c;
        });
    }
    m.filter = function(a, b, c) {
        var d = b[0];
        return c && (a = ":not(" + a + ")"), 1 === b.length && 1 === d.nodeType ? m.find.matchesSelector(d, a) ? [ d ] : [] : m.find.matches(a, m.grep(b, function(a) {
            return 1 === a.nodeType;
        }));
    }, m.fn.extend({
        find: function(a) {
            var b, c = [], d = this, e = d.length;
            if ("string" != typeof a) return this.pushStack(m(a).filter(function() {
                for (b = 0; e > b; b++) if (m.contains(d[b], this)) return !0;
            }));
            for (b = 0; e > b; b++) m.find(a, d[b], c);
            return c = this.pushStack(e > 1 ? m.unique(c) : c), c.selector = this.selector ? this.selector + " " + a : a, c;
        },
        filter: function(a) {
            return this.pushStack(w(this, a || [], !1));
        },
        not: function(a) {
            return this.pushStack(w(this, a || 
[], !0));
        },
        is: function(a) {
            return !!w(this, "string" == typeof a && t.test(a) ? m(a) : a || [], !1).length;
        }
    });
    var x, y = a.document, z = /^(?:\s*(<[\w\W]+>)[^>]*|#([\w-]*))$/, A = m.fn.init = function(a, b) {
        var c, d;
        if (!a) return this;
        if ("string" == typeof a) {
            if (c = "<" === a.charAt(0) && ">" === a.charAt(a.length - 1) && a.length >= 3 ? [ null, a, null ] : z.exec(a), !c || !c[1] && b) return !b || b.jquery ? (b || x).find(a) : this.constructor(b).find(a);
            if (c[1]) {
                if (b = b instanceof m ? b[0] : b, m.merge(this, m.parseHTML(c[1], b && b.nodeType ? b.ownerDocument || b : y, !0)), u.test(c[1]) && m.isPlainObject(b)) for (c in b) m.isFunction(this[c]) ? this[c](b[c]) : this.attr(c, b[c]);
                return this;
            }
            if (d = y.getElementById(c[2]), d && d.parentNode) {
                if (d.id !== c[2]) return x.find(a);
                
this.length = 1, this[0] = d;
            }
            return this.context = y, this.selector = a, this;
        }
        return a.nodeType ? (this.context = this[0] = a, this.length = 1, this) : m.isFunction(a) ? "undefined" != typeof x.ready ? x.ready(a) : a(m) : (void 0 !== a.selector && (this.selector = a.selector, this.context = a.context), m.makeArray(a, this));
    };
    A.prototype = m.fn, x = m(y);
    var B = /^(?:parents|prev(?:Until|All))/, C = {
        children: !0,
        contents: !0,
        next: !0,
        prev: !0
    };
    m.extend({
        dir: function(a, b, c) {
            var d = [], e = a[b];
            while (e && 9 !== e.nodeType && (void 0 === c || 1 !== e.nodeType || !m(e).is(c))) 1 === e.nodeType && d.push(e), e = e[b];
            return d;
        },
        sibling: function(a, b) {
            for (var c = []; a; a = a.nextSibling) 1 === a.nodeType && a !== b && c.push(a);
            return c;
        }
    }), m.fn.extend({
        has: function(
a) {
            var b, c = m(a, this), d = c.length;
            return this.filter(function() {
                for (b = 0; d > b; b++) if (m.contains(this, c[b])) return !0;
            });
        },
        closest: function(a, b) {
            for (var c, d = 0, e = this.length, f = [], g = t.test(a) || "string" != typeof a ? m(a, b || this.context) : 0; e > d; d++) for (c = this[d]; c && c !== b; c = c.parentNode) if (c.nodeType < 11 && (g ? g.index(c) > -1 : 1 === c.nodeType && m.find.matchesSelector(c, a))) {
                f.push(c);
                break;
            }
            return this.pushStack(f.length > 1 ? m.unique(f) : f);
        },
        index: function(a) {
            return a ? "string" == typeof a ? m.inArray(this[0], m(a)) : m.inArray(a.jquery ? a[0] : a, this) : this[0] && this[0].parentNode ? this.first().prevAll().length : -1;
        },
        add: function(a, b) {
            return this.pushStack(m.unique(m.merge(this.get(), m(a, b))));
        },
        
addBack: function(a) {
            return this.add(null == a ? this.prevObject : this.prevObject.filter(a));
        }
    });
    function D(a, b) {
        do a = a[b]; while (a && 1 !== a.nodeType);
        return a;
    }
    m.each({
        parent: function(a) {
            var b = a.parentNode;
            return b && 11 !== b.nodeType ? b : null;
        },
        parents: function(a) {
            return m.dir(a, "parentNode");
        },
        parentsUntil: function(a, b, c) {
            return m.dir(a, "parentNode", c);
        },
        next: function(a) {
            return D(a, "nextSibling");
        },
        prev: function(a) {
            return D(a, "previousSibling");
        },
        nextAll: function(a) {
            return m.dir(a, "nextSibling");
        },
        prevAll: function(a) {
            return m.dir(a, "previousSibling");
        },
        nextUntil: function(a, b, c) {
            return m.dir(a, "nextSibling", c);
        },
        prevUntil
: function(a, b, c) {
            return m.dir(a, "previousSibling", c);
        },
        siblings: function(a) {
            return m.sibling((a.parentNode || {}).firstChild, a);
        },
        children: function(a) {
            return m.sibling(a.firstChild);
        },
        contents: function(a) {
            return m.nodeName(a, "iframe") ? a.contentDocument || a.contentWindow.document : m.merge([], a.childNodes);
        }
    }, function(a, b) {
        m.fn[a] = function(c, d) {
            var e = m.map(this, b, c);
            return "Until" !== a.slice(-5) && (d = c), d && "string" == typeof d && (e = m.filter(d, e)), this.length > 1 && (C[a] || (e = m.unique(e)), B.test(a) && (e = e.reverse())), this.pushStack(e);
        };
    });
    var E = /\S+/g, F = {};
    function G(a) {
        var b = F[a] = {};
        return m.each(a.match(E) || [], function(a, c) {
            b[c] = !0;
        }), b;
    }
    m.Callbacks = function(a) {
        a = "string" == typeof 
a ? F[a] || G(a) : m.extend({}, a);
        var b, c, d, e, f, g, h = [], i = !a.once && [], j = function(l) {
            for (c = a.memory && l, d = !0, f = g || 0, g = 0, e = h.length, b = !0; h && e > f; f++) if (h[f].apply(l[0], l[1]) === !1 && a.stopOnFalse) {
                c = !1;
                break;
            }
            b = !1, h && (i ? i.length && j(i.shift()) : c ? h = [] : k.disable());
        }, k = {
            add: function() {
                if (h) {
                    var d = h.length;
                    !function f(b) {
                        m.each(b, function(b, c) {
                            var d = m.type(c);
                            "function" === d ? a.unique && k.has(c) || h.push(c) : c && c.length && "string" !== d && f(c);
                        });
                    }(arguments), b ? e = h.length : c && (g = d, j(c));
                }
                return this;
            },
            remove: function() {
                return h && 
m.each(arguments, function(a, c) {
                    var d;
                    while ((d = m.inArray(c, h, d)) > -1) h.splice(d, 1), b && (e >= d && e--, f >= d && f--);
                }), this;
            },
            has: function(a) {
                return a ? m.inArray(a, h) > -1 : !!h && !!h.length;
            },
            empty: function() {
                return h = [], e = 0, this;
            },
            disable: function() {
                return h = i = c = void 0, this;
            },
            disabled: function() {
                return !h;
            },
            lock: function() {
                return i = void 0, c || k.disable(), this;
            },
            locked: function() {
                return !i;
            },
            fireWith: function(a, c) {
                return !h || d && !i || (c = c || [], c = [ a, c.slice ? c.slice() : c ], b ? i.push(c) : j(c)), this;
            },
            fire: function() {
                return k
.fireWith(this, arguments), this;
            },
            fired: function() {
                return !!d;
            }
        };
        return k;
    }, m.extend({
        Deferred: function(a) {
            var b = [ [ "resolve", "done", m.Callbacks("once memory"), "resolved" ], [ "reject", "fail", m.Callbacks("once memory"), "rejected" ], [ "notify", "progress", m.Callbacks("memory") ] ], c = "pending", d = {
                state: function() {
                    return c;
                },
                always: function() {
                    return e.done(arguments).fail(arguments), this;
                },
                then: function() {
                    var a = arguments;
                    return m.Deferred(function(c) {
                        m.each(b, function(b, f) {
                            var g = m.isFunction(a[b]) && a[b];
                            e[f[1]](function() {
                                var a = g && g.apply(this, arguments);
                                
a && m.isFunction(a.promise) ? a.promise().done(c.resolve).fail(c.reject).progress(c.notify) : c[f[0] + "With"](this === d ? c.promise() : this, g ? [ a ] : arguments);
                            });
                        }), a = null;
                    }).promise();
                },
                promise: function(a) {
                    return null != a ? m.extend(a, d) : d;
                }
            }, e = {};
            return d.pipe = d.then, m.each(b, function(a, f) {
                var g = f[2], h = f[3];
                d[f[1]] = g.add, h && g.add(function() {
                    c = h;
                }, b[1 ^ a][2].disable, b[2][2].lock), e[f[0]] = function() {
                    return e[f[0] + "With"](this === e ? d : this, arguments), this;
                }, e[f[0] + "With"] = g.fireWith;
            }), d.promise(e), a && a.call(e, e), e;
        },
        when: function(a) {
            var b = 0, c = d.call(arguments), e = c.length, f = 1 !== e || a && 
m.isFunction(a.promise) ? e : 0, g = 1 === f ? a : m.Deferred(), h = function(a, b, c) {
                return function(e) {
                    b[a] = this, c[a] = arguments.length > 1 ? d.call(arguments) : e, c === i ? g.notifyWith(b, c) : --f || g.resolveWith(b, c);
                };
            }, i, j, k;
            if (e > 1) for (i = new Array(e), j = new Array(e), k = new Array(e); e > b; b++) c[b] && m.isFunction(c[b].promise) ? c[b].promise().done(h(b, k, c)).fail(g.reject).progress(h(b, j, i)) : --f;
            return f || g.resolveWith(k, c), g.promise();
        }
    });
    var H;
    m.fn.ready = function(a) {
        return m.ready.promise().done(a), this;
    }, m.extend({
        isReady: !1,
        readyWait: 1,
        holdReady: function(a) {
            a ? m.readyWait++ : m.ready(!0);
        },
        ready: function(a) {
            if (a === !0 ? !--m.readyWait : !m.isReady) {
                if (!y.body) return setTimeout(m.ready);
                m.isReady = !0
, a !== !0 && --m.readyWait > 0 || (H.resolveWith(y, [ m ]), m.fn.triggerHandler && (m(y).triggerHandler("ready"), m(y).off("ready")));
            }
        }
    });
    function I() {
        y.addEventListener ? (y.removeEventListener("DOMContentLoaded", J, !1), a.removeEventListener("load", J, !1)) : (y.detachEvent("onreadystatechange", J), a.detachEvent("onload", J));
    }
    function J() {
        (y.addEventListener || "load" === event.type || "complete" === y.readyState) && (I(), m.ready());
    }
    m.ready.promise = function(b) {
        if (!H) if (H = m.Deferred(), "complete" === y.readyState) setTimeout(m.ready); else if (y.addEventListener) y.addEventListener("DOMContentLoaded", J, !1), a.addEventListener("load", J, !1); else {
            y.attachEvent("onreadystatechange", J), a.attachEvent("onload", J);
            var c = !1;
            try {
                c = null == a.frameElement && y.documentElement;
            } catch (d) {}
            c && c.doScroll && !
function e() {
                if (!m.isReady) {
                    try {
                        c.doScroll("left");
                    } catch (a) {
                        return setTimeout(e, 50);
                    }
                    I(), m.ready();
                }
            }();
        }
        return H.promise(b);
    };
    var K = "undefined", L;
    for (L in m(k)) break;
    k.ownLast = "0" !== L, k.inlineBlockNeedsLayout = !1, m(function() {
        var a, b, c, d;
        c = y.getElementsByTagName("body")[0], c && c.style && (b = y.createElement("div"), d = y.createElement("div"), d.style.cssText = "position:absolute;border:0;width:0;height:0;top:0;left:-9999px", c.appendChild(d).appendChild(b), typeof b.style.zoom !== K && (b.style.cssText = "display:inline;margin:0;border:0;padding:1px;width:1px;zoom:1", k.inlineBlockNeedsLayout = a = 3 === b.offsetWidth, a && (c.style.zoom = 1)), c.removeChild(d));
    }), function() {
        var a = y.createElement("div");
        
if (null == k.deleteExpando) {
            k.deleteExpando = !0;
            try {
                delete a.test;
            } catch (b) {
                k.deleteExpando = !1;
            }
        }
        a = null;
    }(), m.acceptData = function(a) {
        var b = m.noData[(a.nodeName + " ").toLowerCase()], c = +a.nodeType || 1;
        return 1 !== c && 9 !== c ? !1 : !b || b !== !0 && a.getAttribute("classid") === b;
    };
    var M = /^(?:\{[\w\W]*\}|\[[\w\W]*\])$/, N = /([A-Z])/g;
    function O(a, b, c) {
        if (void 0 === c && 1 === a.nodeType) {
            var d = "data-" + b.replace(N, "-$1").toLowerCase();
            if (c = a.getAttribute(d), "string" == typeof c) {
                try {
                    c = "true" === c ? !0 : "false" === c ? !1 : "null" === c ? null : +c + "" === c ? +c : M.test(c) ? m.parseJSON(c) : c;
                } catch (e) {}
                m.data(a, b, c);
            } else c = void 0;
        }
        return c;
    }
    function P
(a) {
        var b;
        for (b in a) if (("data" !== b || !m.isEmptyObject(a[b])) && "toJSON" !== b) return !1;
        return !0;
    }
    function Q(a, b, d, e) {
        if (m.acceptData(a)) {
            var f, g, h = m.expando, i = a.nodeType, j = i ? m.cache : a, k = i ? a[h] : a[h] && h;
            if (k && j[k] && (e || j[k].data) || void 0 !== d || "string" != typeof b) return k || (k = i ? a[h] = c.pop() || m.guid++ : h), j[k] || (j[k] = i ? {} : {
                toJSON: m.noop
            }), ("object" == typeof b || "function" == typeof b) && (e ? j[k] = m.extend(j[k], b) : j[k].data = m.extend(j[k].data, b)), g = j[k], e || (g.data || (g.data = {}), g = g.data), void 0 !== d && (g[m.camelCase(b)] = d), "string" == typeof b ? (f = g[b], null == f && (f = g[m.camelCase(b)])) : f = g, f;
        }
    }
    function R(a, b, c) {
        if (m.acceptData(a)) {
            var d, e, f = a.nodeType, g = f ? m.cache : a, h = f ? a[m.expando] : m.expando;
            if (g[
h]) {
                if (b && (d = c ? g[h] : g[h].data)) {
                    m.isArray(b) ? b = b.concat(m.map(b, m.camelCase)) : b in d ? b = [ b ] : (b = m.camelCase(b), b = b in d ? [ b ] : b.split(" ")), e = b.length;
                    while (e--) delete d[b[e]];
                    if (c ? !P(d) : !m.isEmptyObject(d)) return;
                }
                (c || (delete g[h].data, P(g[h]))) && (f ? m.cleanData([ a ], !0) : k.deleteExpando || g != g.window ? delete g[h] : g[h] = null);
            }
        }
    }
    m.extend({
        cache: {},
        noData: {
            "applet ": !0,
            "embed ": !0,
            "object ": "clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
        },
        hasData: function(a) {
            return a = a.nodeType ? m.cache[a[m.expando]] : a[m.expando], !!a && !P(a);
        },
        data: function(a, b, c) {
            return Q(a, b, c);
        },
        removeData: function(a, b) {
            return R(a, b);
        },
        
_data: function(a, b, c) {
            return Q(a, b, c, !0);
        },
        _removeData: function(a, b) {
            return R(a, b, !0);
        }
    }), m.fn.extend({
        data: function(a, b) {
            var c, d, e, f = this[0], g = f && f.attributes;
            if (void 0 === a) {
                if (this.length && (e = m.data(f), 1 === f.nodeType && !m._data(f, "parsedAttrs"))) {
                    c = g.length;
                    while (c--) g[c] && (d = g[c].name, 0 === d.indexOf("data-") && (d = m.camelCase(d.slice(5)), O(f, d, e[d])));
                    m._data(f, "parsedAttrs", !0);
                }
                return e;
            }
            return "object" == typeof a ? this.each(function() {
                m.data(this, a);
            }) : arguments.length > 1 ? this.each(function() {
                m.data(this, a, b);
            }) : f ? O(f, a, m.data(f, a)) : void 0;
        },
        removeData: function(a) {
            return this.each(function(
) {
                m.removeData(this, a);
            });
        }
    }), m.extend({
        queue: function(a, b, c) {
            var d;
            return a ? (b = (b || "fx") + "queue", d = m._data(a, b), c && (!d || m.isArray(c) ? d = m._data(a, b, m.makeArray(c)) : d.push(c)), d || []) : void 0;
        },
        dequeue: function(a, b) {
            b = b || "fx";
            var c = m.queue(a, b), d = c.length, e = c.shift(), f = m._queueHooks(a, b), g = function() {
                m.dequeue(a, b);
            };
            "inprogress" === e && (e = c.shift(), d--), e && ("fx" === b && c.unshift("inprogress"), delete f.stop, e.call(a, g, f)), !d && f && f.empty.fire();
        },
        _queueHooks: function(a, b) {
            var c = b + "queueHooks";
            return m._data(a, c) || m._data(a, c, {
                empty: m.Callbacks("once memory").add(function() {
                    m._removeData(a, b + "queue"), m._removeData(a, c);
                })
            
});
        }
    }), m.fn.extend({
        queue: function(a, b) {
            var c = 2;
            return "string" != typeof a && (b = a, a = "fx", c--), arguments.length < c ? m.queue(this[0], a) : void 0 === b ? this : this.each(function() {
                var c = m.queue(this, a, b);
                m._queueHooks(this, a), "fx" === a && "inprogress" !== c[0] && m.dequeue(this, a);
            });
        },
        dequeue: function(a) {
            return this.each(function() {
                m.dequeue(this, a);
            });
        },
        clearQueue: function(a) {
            return this.queue(a || "fx", []);
        },
        promise: function(a, b) {
            var c, d = 1, e = m.Deferred(), f = this, g = this.length, h = function() {
                --d || e.resolveWith(f, [ f ]);
            };
            "string" != typeof a && (b = a, a = void 0), a = a || "fx";
            while (g--) c = m._data(f[g], a + "queueHooks"), c && c.empty && (d++, c.empty.add(h))
;
            return h(), e.promise(b);
        }
    });
    var S = /[+-]?(?:\d*\.|)\d+(?:[eE][+-]?\d+|)/.source, T = [ "Top", "Right", "Bottom", "Left" ], U = function(a, b) {
        return a = b || a, "none" === m.css(a, "display") || !m.contains(a.ownerDocument, a);
    }, V = m.access = function(a, b, c, d, e, f, g) {
        var h = 0, i = a.length, j = null == c;
        if ("object" === m.type(c)) {
            e = !0;
            for (h in c) m.access(a, b, h, c[h], !0, f, g);
        } else if (void 0 !== d && (e = !0, m.isFunction(d) || (g = !0), j && (g ? (b.call(a, d), b = null) : (j = b, b = function(a, b, c) {
            return j.call(m(a), c);
        })), b)) for (; i > h; h++) b(a[h], c, g ? d : d.call(a[h], h, b(a[h], c)));
        return e ? a : j ? b.call(a) : i ? b(a[0], c) : f;
    }, W = /^(?:checkbox|radio)$/i;
    !function() {
        var a = y.createElement("input"), b = y.createElement("div"), c = y.createDocumentFragment();
        if (b.innerHTML = "  <link/><table></table><a href='/a'>a</a><input type='checkbox'/>"
, k.leadingWhitespace = 3 === b.firstChild.nodeType, k.tbody = !b.getElementsByTagName("tbody").length, k.htmlSerialize = !!b.getElementsByTagName("link").length, k.html5Clone = "<:nav></:nav>" !== y.createElement("nav").cloneNode(!0).outerHTML, a.type = "checkbox", a.checked = !0, c.appendChild(a), k.appendChecked = a.checked, b.innerHTML = "<textarea>x</textarea>", k.noCloneChecked = !!b.cloneNode(!0).lastChild.defaultValue, c.appendChild(b), b.innerHTML = "<input type='radio' checked='checked' name='t'/>", k.checkClone = b.cloneNode(!0).cloneNode(!0).lastChild.checked, k.noCloneEvent = !0, b.attachEvent && (b.attachEvent("onclick", function() {
            k.noCloneEvent = !1;
        }), b.cloneNode(!0).click()), null == k.deleteExpando) {
            k.deleteExpando = !0;
            try {
                delete b.test;
            } catch (d) {
                k.deleteExpando = !1;
            }
        }
    }(), function() {
        var b, c, d = y.createElement("div");
        
for (b in {
            submit: !0,
            change: !0,
            focusin: !0
        }) c = "on" + b, (k[b + "Bubbles"] = c in a) || (d.setAttribute(c, "t"), k[b + "Bubbles"] = d.attributes[c].expando === !1);
        d = null;
    }();
    var X = /^(?:input|select|textarea)$/i, Y = /^key/, Z = /^(?:mouse|pointer|contextmenu)|click/, $ = /^(?:focusinfocus|focusoutblur)$/, _ = /^([^.]*)(?:\.(.+)|)$/;
    function ab() {
        return !0;
    }
    function bb() {
        return !1;
    }
    function cb() {
        try {
            return y.activeElement;
        } catch (a) {}
    }
    m.event = {
        global: {},
        add: function(a, b, c, d, e) {
            var f, g, h, i, j, k, l, n, o, p, q, r = m._data(a);
            if (r) {
                c.handler && (i = c, c = i.handler, e = i.selector), c.guid || (c.guid = m.guid++), (g = r.events) || (g = r.events = {}), (k = r.handle) || (k = r.handle = function(a) {
                    return typeof m === K || a && m.event
.triggered === a.type ? void 0 : m.event.dispatch.apply(k.elem, arguments);
                }, k.elem = a), b = (b || "").match(E) || [ "" ], h = b.length;
                while (h--) f = _.exec(b[h]) || [], o = q = f[1], p = (f[2] || "").split(".").sort(), o && (j = m.event.special[o] || {}, o = (e ? j.delegateType : j.bindType) || o, j = m.event.special[o] || {}, l = m.extend({
                    type: o,
                    origType: q,
                    data: d,
                    handler: c,
                    guid: c.guid,
                    selector: e,
                    needsContext: e && m.expr.match.needsContext.test(e),
                    namespace: p.join(".")
                }, i), (n = g[o]) || (n = g[o] = [], n.delegateCount = 0, j.setup && j.setup.call(a, d, p, k) !== !1 || (a.addEventListener ? a.addEventListener(o, k, !1) : a.attachEvent && a.attachEvent("on" + o, k))), j.add && (j.add.call(a, l), l.handler.guid || (l.handler.guid = c.guid)), e ? n.splice(n.delegateCount++
, 0, l) : n.push(l), m.event.global[o] = !0);
                a = null;
            }
        },
        remove: function(a, b, c, d, e) {
            var f, g, h, i, j, k, l, n, o, p, q, r = m.hasData(a) && m._data(a);
            if (r && (k = r.events)) {
                b = (b || "").match(E) || [ "" ], j = b.length;
                while (j--) if (h = _.exec(b[j]) || [], o = q = h[1], p = (h[2] || "").split(".").sort(), o) {
                    l = m.event.special[o] || {}, o = (d ? l.delegateType : l.bindType) || o, n = k[o] || [], h = h[2] && new RegExp("(^|\\.)" + p.join("\\.(?:.*\\.|)") + "(\\.|$)"), i = f = n.length;
                    while (f--) g = n[f], !e && q !== g.origType || c && c.guid !== g.guid || h && !h.test(g.namespace) || d && d !== g.selector && ("**" !== d || !g.selector) || (n.splice(f, 1), g.selector && n.delegateCount--, l.remove && l.remove.call(a, g));
                    i && !n.length && (l.teardown && l.teardown.call(a, p, r.handle) !== !1 || m.removeEvent
(a, o, r.handle), delete k[o]);
                } else for (o in k) m.event.remove(a, o + b[j], c, d, !0);
                m.isEmptyObject(k) && (delete r.handle, m._removeData(a, "events"));
            }
        },
        trigger: function(b, c, d, e) {
            var f, g, h, i, k, l, n, o = [ d || y ], p = j.call(b, "type") ? b.type : b, q = j.call(b, "namespace") ? b.namespace.split(".") : [];
            if (h = l = d = d || y, 3 !== d.nodeType && 8 !== d.nodeType && !$.test(p + m.event.triggered) && (p.indexOf(".") >= 0 && (q = p.split("."), p = q.shift(), q.sort()), g = p.indexOf(":") < 0 && "on" + p, b = b[m.expando] ? b : new m.Event(p, "object" == typeof b && b), b.isTrigger = e ? 2 : 3, b.namespace = q.join("."), b.namespace_re = b.namespace ? new RegExp("(^|\\.)" + q.join("\\.(?:.*\\.|)") + "(\\.|$)") : null, b.result = void 0, b.target || (b.target = d), c = null == c ? [ b ] : m.makeArray(c, [ b ]), k = m.event.special[p] || {}, e || !k.trigger || k.trigger.apply(d, c) !== !1
)) {
                if (!e && !k.noBubble && !m.isWindow(d)) {
                    for (i = k.delegateType || p, $.test(i + p) || (h = h.parentNode); h; h = h.parentNode) o.push(h), l = h;
                    l === (d.ownerDocument || y) && o.push(l.defaultView || l.parentWindow || a);
                }
                n = 0;
                while ((h = o[n++]) && !b.isPropagationStopped()) b.type = n > 1 ? i : k.bindType || p, f = (m._data(h, "events") || {})[b.type] && m._data(h, "handle"), f && f.apply(h, c), f = g && h[g], f && f.apply && m.acceptData(h) && (b.result = f.apply(h, c), b.result === !1 && b.preventDefault());
                if (b.type = p, !e && !b.isDefaultPrevented() && (!k._default || k._default.apply(o.pop(), c) === !1) && m.acceptData(d) && g && d[p] && !m.isWindow(d)) {
                    l = d[g], l && (d[g] = null), m.event.triggered = p;
                    try {
                        d[p]();
                    } catch (r) {}
                    m.event.
triggered = void 0, l && (d[g] = l);
                }
                return b.result;
            }
        },
        dispatch: function(a) {
            a = m.event.fix(a);
            var b, c, e, f, g, h = [], i = d.call(arguments), j = (m._data(this, "events") || {})[a.type] || [], k = m.event.special[a.type] || {};
            if (i[0] = a, a.delegateTarget = this, !k.preDispatch || k.preDispatch.call(this, a) !== !1) {
                h = m.event.handlers.call(this, a, j), b = 0;
                while ((f = h[b++]) && !a.isPropagationStopped()) {
                    a.currentTarget = f.elem, g = 0;
                    while ((e = f.handlers[g++]) && !a.isImmediatePropagationStopped()) (!a.namespace_re || a.namespace_re.test(e.namespace)) && (a.handleObj = e, a.data = e.data, c = ((m.event.special[e.origType] || {}).handle || e.handler).apply(f.elem, i), void 0 !== c && (a.result = c) === !1 && (a.preventDefault(), a.stopPropagation()));
                }
                return k
.postDispatch && k.postDispatch.call(this, a), a.result;
            }
        },
        handlers: function(a, b) {
            var c, d, e, f, g = [], h = b.delegateCount, i = a.target;
            if (h && i.nodeType && (!a.button || "click" !== a.type)) for (; i != this; i = i.parentNode || this) if (1 === i.nodeType && (i.disabled !== !0 || "click" !== a.type)) {
                for (e = [], f = 0; h > f; f++) d = b[f], c = d.selector + " ", void 0 === e[c] && (e[c] = d.needsContext ? m(c, this).index(i) >= 0 : m.find(c, this, null, [ i ]).length), e[c] && e.push(d);
                e.length && g.push({
                    elem: i,
                    handlers: e
                });
            }
            return h < b.length && g.push({
                elem: this,
                handlers: b.slice(h)
            }), g;
        },
        fix: function(a) {
            if (a[m.expando]) return a;
            var b, c, d, e = a.type, f = a, g = this.fixHooks[e];
            g || (
this.fixHooks[e] = g = Z.test(e) ? this.mouseHooks : Y.test(e) ? this.keyHooks : {}), d = g.props ? this.props.concat(g.props) : this.props, a = new m.Event(f), b = d.length;
            while (b--) c = d[b], a[c] = f[c];
            return a.target || (a.target = f.srcElement || y), 3 === a.target.nodeType && (a.target = a.target.parentNode), a.metaKey = !!a.metaKey, g.filter ? g.filter(a, f) : a;
        },
        props: "altKey bubbles cancelable ctrlKey currentTarget eventPhase metaKey relatedTarget shiftKey target timeStamp view which".split(" "),
        fixHooks: {},
        keyHooks: {
            props: "char charCode key keyCode".split(" "),
            filter: function(a, b) {
                return null == a.which && (a.which = null != b.charCode ? b.charCode : b.keyCode), a;
            }
        },
        mouseHooks: {
            props: "button buttons clientX clientY fromElement offsetX offsetY pageX pageY screenX screenY toElement".split(" "),
            filter: function(
a, b) {
                var c, d, e, f = b.button, g = b.fromElement;
                return null == a.pageX && null != b.clientX && (d = a.target.ownerDocument || y, e = d.documentElement, c = d.body, a.pageX = b.clientX + (e && e.scrollLeft || c && c.scrollLeft || 0) - (e && e.clientLeft || c && c.clientLeft || 0), a.pageY = b.clientY + (e && e.scrollTop || c && c.scrollTop || 0) - (e && e.clientTop || c && c.clientTop || 0)), !a.relatedTarget && g && (a.relatedTarget = g === a.target ? b.toElement : g), a.which || void 0 === f || (a.which = 1 & f ? 1 : 2 & f ? 3 : 4 & f ? 2 : 0), a;
            }
        },
        special: {
            load: {
                noBubble: !0
            },
            focus: {
                trigger: function() {
                    if (this !== cb() && this.focus) try {
                        return this.focus(), !1;
                    } catch (a) {}
                },
                delegateType: "focusin"
            },
            blur: {
                
trigger: function() {
                    return this === cb() && this.blur ? (this.blur(), !1) : void 0;
                },
                delegateType: "focusout"
            },
            click: {
                trigger: function() {
                    return m.nodeName(this, "input") && "checkbox" === this.type && this.click ? (this.click(), !1) : void 0;
                },
                _default: function(a) {
                    return m.nodeName(a.target, "a");
                }
            },
            beforeunload: {
                postDispatch: function(a) {
                    void 0 !== a.result && a.originalEvent && (a.originalEvent.returnValue = a.result);
                }
            }
        },
        simulate: function(a, b, c, d) {
            var e = m.extend(new m.Event, c, {
                type: a,
                isSimulated: !0,
                originalEvent: {}
            });
            d ? m.event.trigger(e, null, b) : m.event.dispatch.call(b, e), 
e.isDefaultPrevented() && c.preventDefault();
        }
    }, m.removeEvent = y.removeEventListener ? function(a, b, c) {
        a.removeEventListener && a.removeEventListener(b, c, !1);
    } : function(a, b, c) {
        var d = "on" + b;
        a.detachEvent && (typeof a[d] === K && (a[d] = null), a.detachEvent(d, c));
    }, m.Event = function(a, b) {
        return this instanceof m.Event ? (a && a.type ? (this.originalEvent = a, this.type = a.type, this.isDefaultPrevented = a.defaultPrevented || void 0 === a.defaultPrevented && a.returnValue === !1 ? ab : bb) : this.type = a, b && m.extend(this, b), this.timeStamp = a && a.timeStamp || m.now(), void (this[m.expando] = !0)) : new m.Event(a, b);
    }, m.Event.prototype = {
        isDefaultPrevented: bb,
        isPropagationStopped: bb,
        isImmediatePropagationStopped: bb,
        preventDefault: function() {
            var a = this.originalEvent;
            this.isDefaultPrevented = ab, a && (a.preventDefault ? a.preventDefault
() : a.returnValue = !1);
        },
        stopPropagation: function() {
            var a = this.originalEvent;
            this.isPropagationStopped = ab, a && (a.stopPropagation && a.stopPropagation(), a.cancelBubble = !0);
        },
        stopImmediatePropagation: function() {
            var a = this.originalEvent;
            this.isImmediatePropagationStopped = ab, a && a.stopImmediatePropagation && a.stopImmediatePropagation(), this.stopPropagation();
        }
    }, m.each({
        mouseenter: "mouseover",
        mouseleave: "mouseout",
        pointerenter: "pointerover",
        pointerleave: "pointerout"
    }, function(a, b) {
        m.event.special[a] = {
            delegateType: b,
            bindType: b,
            handle: function(a) {
                var c, d = this, e = a.relatedTarget, f = a.handleObj;
                return (!e || e !== d && !m.contains(d, e)) && (a.type = f.origType, c = f.handler.apply(this, arguments), a.type = b), c;
            }
        
};
    }), k.submitBubbles || (m.event.special.submit = {
        setup: function() {
            return m.nodeName(this, "form") ? !1 : void m.event.add(this, "click._submit keypress._submit", function(a) {
                var b = a.target, c = m.nodeName(b, "input") || m.nodeName(b, "button") ? b.form : void 0;
                c && !m._data(c, "submitBubbles") && (m.event.add(c, "submit._submit", function(a) {
                    a._submit_bubble = !0;
                }), m._data(c, "submitBubbles", !0));
            });
        },
        postDispatch: function(a) {
            a._submit_bubble && (delete a._submit_bubble, this.parentNode && !a.isTrigger && m.event.simulate("submit", this.parentNode, a, !0));
        },
        teardown: function() {
            return m.nodeName(this, "form") ? !1 : void m.event.remove(this, "._submit");
        }
    }), k.changeBubbles || (m.event.special.change = {
        setup: function() {
            return X.test(this.nodeName) ? (("checkbox" === 
this.type || "radio" === this.type) && (m.event.add(this, "propertychange._change", function(a) {
                "checked" === a.originalEvent.propertyName && (this._just_changed = !0);
            }), m.event.add(this, "click._change", function(a) {
                this._just_changed && !a.isTrigger && (this._just_changed = !1), m.event.simulate("change", this, a, !0);
            })), !1) : void m.event.add(this, "beforeactivate._change", function(a) {
                var b = a.target;
                X.test(b.nodeName) && !m._data(b, "changeBubbles") && (m.event.add(b, "change._change", function(a) {
                    !this.parentNode || a.isSimulated || a.isTrigger || m.event.simulate("change", this.parentNode, a, !0);
                }), m._data(b, "changeBubbles", !0));
            });
        },
        handle: function(a) {
            var b = a.target;
            return this !== b || a.isSimulated || a.isTrigger || "radio" !== b.type && "checkbox" !== b.type ? a.handleObj.handler
.apply(this, arguments) : void 0;
        },
        teardown: function() {
            return m.event.remove(this, "._change"), !X.test(this.nodeName);
        }
    }), k.focusinBubbles || m.each({
        focus: "focusin",
        blur: "focusout"
    }, function(a, b) {
        var c = function(a) {
            m.event.simulate(b, a.target, m.event.fix(a), !0);
        };
        m.event.special[b] = {
            setup: function() {
                var d = this.ownerDocument || this, e = m._data(d, b);
                e || d.addEventListener(a, c, !0), m._data(d, b, (e || 0) + 1);
            },
            teardown: function() {
                var d = this.ownerDocument || this, e = m._data(d, b) - 1;
                e ? m._data(d, b, e) : (d.removeEventListener(a, c, !0), m._removeData(d, b));
            }
        };
    }), m.fn.extend({
        on: function(a, b, c, d, e) {
            var f, g;
            if ("object" == typeof a) {
                "string" != typeof b && (
c = c || b, b = void 0);
                for (f in a) this.on(f, b, c, a[f], e);
                return this;
            }
            if (null == c && null == d ? (d = b, c = b = void 0) : null == d && ("string" == typeof b ? (d = c, c = void 0) : (d = c, c = b, b = void 0)), d === !1) d = bb; else if (!d) return this;
            return 1 === e && (g = d, d = function(a) {
                return m().off(a), g.apply(this, arguments);
            }, d.guid = g.guid || (g.guid = m.guid++)), this.each(function() {
                m.event.add(this, a, d, c, b);
            });
        },
        one: function(a, b, c, d) {
            return this.on(a, b, c, d, 1);
        },
        off: function(a, b, c) {
            var d, e;
            if (a && a.preventDefault && a.handleObj) return d = a.handleObj, m(a.delegateTarget).off(d.namespace ? d.origType + "." + d.namespace : d.origType, d.selector, d.handler), this;
            if ("object" == typeof a) {
                for (e in a) this
.off(e, b, a[e]);
                return this;
            }
            return (b === !1 || "function" == typeof b) && (c = b, b = void 0), c === !1 && (c = bb), this.each(function() {
                m.event.remove(this, a, c, b);
            });
        },
        trigger: function(a, b) {
            return this.each(function() {
                m.event.trigger(a, b, this);
            });
        },
        triggerHandler: function(a, b) {
            var c = this[0];
            return c ? m.event.trigger(a, b, c, !0) : void 0;
        }
    });
    function db(a) {
        var b = eb.split("|"), c = a.createDocumentFragment();
        if (c.createElement) while (b.length) c.createElement(b.pop());
        return c;
    }
    var eb = "abbr|article|aside|audio|bdi|canvas|data|datalist|details|figcaption|figure|footer|header|hgroup|mark|meter|nav|output|progress|section|summary|time|video", fb = / jQuery\d+="(?:null|\d+)"/g, gb = new RegExp("<(?:" + eb + ")[\\s/>]", "i"), hb = /^\s+/
, ib = /<(?!area|br|col|embed|hr|img|input|link|meta|param)(([\w:]+)[^>]*)\/>/gi, jb = /<([\w:]+)/, kb = /<tbody/i, lb = /<|&#?\w+;/, mb = /<(?:script|style|link)/i, nb = /checked\s*(?:[^=]|=\s*.checked.)/i, ob = /^$|\/(?:java|ecma)script/i, pb = /^true\/(.*)/, qb = /^\s*<!(?:\[CDATA\[|--)|(?:\]\]|--)>\s*$/g, rb = {
        option: [ 1, "<select multiple='multiple'>", "</select>" ],
        legend: [ 1, "<fieldset>", "</fieldset>" ],
        area: [ 1, "<map>", "</map>" ],
        param: [ 1, "<object>", "</object>" ],
        thead: [ 1, "<table>", "</table>" ],
        tr: [ 2, "<table><tbody>", "</tbody></table>" ],
        col: [ 2, "<table><tbody></tbody><colgroup>", "</colgroup></table>" ],
        td: [ 3, "<table><tbody><tr>", "</tr></tbody></table>" ],
        _default: k.htmlSerialize ? [ 0, "", "" ] : [ 1, "X<div>", "</div>" ]
    }, sb = db(y), tb = sb.appendChild(y.createElement("div"));
    rb.optgroup = rb.option, rb.tbody = rb.tfoot = rb.colgroup = rb.caption = rb.thead, 
rb.th = rb.td;
    function ub(a, b) {
        var c, d, e = 0, f = typeof a.getElementsByTagName !== K ? a.getElementsByTagName(b || "*") : typeof a.querySelectorAll !== K ? a.querySelectorAll(b || "*") : void 0;
        if (!f) for (f = [], c = a.childNodes || a; null != (d = c[e]); e++) !b || m.nodeName(d, b) ? f.push(d) : m.merge(f, ub(d, b));
        return void 0 === b || b && m.nodeName(a, b) ? m.merge([ a ], f) : f;
    }
    function vb(a) {
        W.test(a.type) && (a.defaultChecked = a.checked);
    }
    function wb(a, b) {
        return m.nodeName(a, "table") && m.nodeName(11 !== b.nodeType ? b : b.firstChild, "tr") ? a.getElementsByTagName("tbody")[0] || a.appendChild(a.ownerDocument.createElement("tbody")) : a;
    }
    function xb(a) {
        return a.type = (null !== m.find.attr(a, "type")) + "/" + a.type, a;
    }
    function yb(a) {
        var b = pb.exec(a.type);
        return b ? a.type = b[1] : a.removeAttribute("type"), a;
    }
    function zb(a, b) {
        
for (var c, d = 0; null != (c = a[d]); d++) m._data(c, "globalEval", !b || m._data(b[d], "globalEval"));
    }
    function Ab(a, b) {
        if (1 === b.nodeType && m.hasData(a)) {
            var c, d, e, f = m._data(a), g = m._data(b, f), h = f.events;
            if (h) {
                delete g.handle, g.events = {};
                for (c in h) for (d = 0, e = h[c].length; e > d; d++) m.event.add(b, c, h[c][d]);
            }
            g.data && (g.data = m.extend({}, g.data));
        }
    }
    function Bb(a, b) {
        var c, d, e;
        if (1 === b.nodeType) {
            if (c = b.nodeName.toLowerCase(), !k.noCloneEvent && b[m.expando]) {
                e = m._data(b);
                for (d in e.events) m.removeEvent(b, d, e.handle);
                b.removeAttribute(m.expando);
            }
            "script" === c && b.text !== a.text ? (xb(b).text = a.text, yb(b)) : "object" === c ? (b.parentNode && (b.outerHTML = a.outerHTML), k.html5Clone && a.innerHTML && !
m.trim(b.innerHTML) && (b.innerHTML = a.innerHTML)) : "input" === c && W.test(a.type) ? (b.defaultChecked = b.checked = a.checked, b.value !== a.value && (b.value = a.value)) : "option" === c ? b.defaultSelected = b.selected = a.defaultSelected : ("input" === c || "textarea" === c) && (b.defaultValue = a.defaultValue);
        }
    }
    m.extend({
        clone: function(a, b, c) {
            var d, e, f, g, h, i = m.contains(a.ownerDocument, a);
            if (k.html5Clone || m.isXMLDoc(a) || !gb.test("<" + a.nodeName + ">") ? f = a.cloneNode(!0) : (tb.innerHTML = a.outerHTML, tb.removeChild(f = tb.firstChild)), !(k.noCloneEvent && k.noCloneChecked || 1 !== a.nodeType && 11 !== a.nodeType || m.isXMLDoc(a))) for (d = ub(f), h = ub(a), g = 0; null != (e = h[g]); ++g) d[g] && Bb(e, d[g]);
            if (b) if (c) for (h = h || ub(a), d = d || ub(f), g = 0; null != (e = h[g]); g++) Ab(e, d[g]); else Ab(a, f);
            return d = ub(f, "script"), d.length > 0 && zb(d, !i && ub(a, "script"
)), d = h = e = null, f;
        },
        buildFragment: function(a, b, c, d) {
            for (var e, f, g, h, i, j, l, n = a.length, o = db(b), p = [], q = 0; n > q; q++) if (f = a[q], f || 0 === f) if ("object" === m.type(f)) m.merge(p, f.nodeType ? [ f ] : f); else if (lb.test(f)) {
                h = h || o.appendChild(b.createElement("div")), i = (jb.exec(f) || [ "", "" ])[1].toLowerCase(), l = rb[i] || rb._default, h.innerHTML = l[1] + f.replace(ib, "<$1></$2>") + l[2], e = l[0];
                while (e--) h = h.lastChild;
                if (!k.leadingWhitespace && hb.test(f) && p.push(b.createTextNode(hb.exec(f)[0])), !k.tbody) {
                    f = "table" !== i || kb.test(f) ? "<table>" !== l[1] || kb.test(f) ? 0 : h : h.firstChild, e = f && f.childNodes.length;
                    while (e--) m.nodeName(j = f.childNodes[e], "tbody") && !j.childNodes.length && f.removeChild(j);
                }
                m.merge(p, h.childNodes), h.textContent = "";
                
while (h.firstChild) h.removeChild(h.firstChild);
                h = o.lastChild;
            } else p.push(b.createTextNode(f));
            h && o.removeChild(h), k.appendChecked || m.grep(ub(p, "input"), vb), q = 0;
            while (f = p[q++]) if ((!d || -1 === m.inArray(f, d)) && (g = m.contains(f.ownerDocument, f), h = ub(o.appendChild(f), "script"), g && zb(h), c)) {
                e = 0;
                while (f = h[e++]) ob.test(f.type || "") && c.push(f);
            }
            return h = null, o;
        },
        cleanData: function(a, b) {
            for (var d, e, f, g, h = 0, i = m.expando, j = m.cache, l = k.deleteExpando, n = m.event.special; null != (d = a[h]); h++) if ((b || m.acceptData(d)) && (f = d[i], g = f && j[f])) {
                if (g.events) for (e in g.events) n[e] ? m.event.remove(d, e) : m.removeEvent(d, e, g.handle);
                j[f] && (delete j[f], l ? delete d[i] : typeof d.removeAttribute !== K ? d.removeAttribute(i) : d[i] = null, c.push
(f));
            }
        }
    }), m.fn.extend({
        text: function(a) {
            return V(this, function(a) {
                return void 0 === a ? m.text(this) : this.empty().append((this[0] && this[0].ownerDocument || y).createTextNode(a));
            }, null, a, arguments.length);
        },
        append: function() {
            return this.domManip(arguments, function(a) {
                if (1 === this.nodeType || 11 === this.nodeType || 9 === this.nodeType) {
                    var b = wb(this, a);
                    b.appendChild(a);
                }
            });
        },
        prepend: function() {
            return this.domManip(arguments, function(a) {
                if (1 === this.nodeType || 11 === this.nodeType || 9 === this.nodeType) {
                    var b = wb(this, a);
                    b.insertBefore(a, b.firstChild);
                }
            });
        },
        before: function() {
            return this.domManip(arguments, function(
a) {
                this.parentNode && this.parentNode.insertBefore(a, this);
            });
        },
        after: function() {
            return this.domManip(arguments, function(a) {
                this.parentNode && this.parentNode.insertBefore(a, this.nextSibling);
            });
        },
        remove: function(a, b) {
            for (var c, d = a ? m.filter(a, this) : this, e = 0; null != (c = d[e]); e++) b || 1 !== c.nodeType || m.cleanData(ub(c)), c.parentNode && (b && m.contains(c.ownerDocument, c) && zb(ub(c, "script")), c.parentNode.removeChild(c));
            return this;
        },
        empty: function() {
            for (var a, b = 0; null != (a = this[b]); b++) {
                1 === a.nodeType && m.cleanData(ub(a, !1));
                while (a.firstChild) a.removeChild(a.firstChild);
                a.options && m.nodeName(a, "select") && (a.options.length = 0);
            }
            return this;
        },
        clone: function(a, b) {
            
return a = null == a ? !1 : a, b = null == b ? a : b, this.map(function() {
                return m.clone(this, a, b);
            });
        },
        html: function(a) {
            return V(this, function(a) {
                var b = this[0] || {}, c = 0, d = this.length;
                if (void 0 === a) return 1 === b.nodeType ? b.innerHTML.replace(fb, "") : void 0;
                if (!("string" != typeof a || mb.test(a) || !k.htmlSerialize && gb.test(a) || !k.leadingWhitespace && hb.test(a) || rb[(jb.exec(a) || [ "", "" ])[1].toLowerCase()])) {
                    a = a.replace(ib, "<$1></$2>");
                    try {
                        for (; d > c; c++) b = this[c] || {}, 1 === b.nodeType && (m.cleanData(ub(b, !1)), b.innerHTML = a);
                        b = 0;
                    } catch (e) {}
                }
                b && this.empty().append(a);
            }, null, a, arguments.length);
        },
        replaceWith: function() {
            var a = 
arguments[0];
            return this.domManip(arguments, function(b) {
                a = this.parentNode, m.cleanData(ub(this)), a && a.replaceChild(b, this);
            }), a && (a.length || a.nodeType) ? this : this.remove();
        },
        detach: function(a) {
            return this.remove(a, !0);
        },
        domManip: function(a, b) {
            a = e.apply([], a);
            var c, d, f, g, h, i, j = 0, l = this.length, n = this, o = l - 1, p = a[0], q = m.isFunction(p);
            if (q || l > 1 && "string" == typeof p && !k.checkClone && nb.test(p)) return this.each(function(c) {
                var d = n.eq(c);
                q && (a[0] = p.call(this, c, d.html())), d.domManip(a, b);
            });
            if (l && (i = m.buildFragment(a, this[0].ownerDocument, !1, this), c = i.firstChild, 1 === i.childNodes.length && (i = c), c)) {
                for (g = m.map(ub(i, "script"), xb), f = g.length; l > j; j++) d = i, j !== o && (d = m.clone(d, !0, !0), 
f && m.merge(g, ub(d, "script"))), b.call(this[j], d, j);
                if (f) for (h = g[g.length - 1].ownerDocument, m.map(g, yb), j = 0; f > j; j++) d = g[j], ob.test(d.type || "") && !m._data(d, "globalEval") && m.contains(h, d) && (d.src ? m._evalUrl && m._evalUrl(d.src) : m.globalEval((d.text || d.textContent || d.innerHTML || "").replace(qb, "")));
                i = c = null;
            }
            return this;
        }
    }), m.each({
        appendTo: "append",
        prependTo: "prepend",
        insertBefore: "before",
        insertAfter: "after",
        replaceAll: "replaceWith"
    }, function(a, b) {
        m.fn[a] = function(a) {
            for (var c, d = 0, e = [], g = m(a), h = g.length - 1; h >= d; d++) c = d === h ? this : this.clone(!0), m(g[d])[b](c), f.apply(e, c.get());
            return this.pushStack(e);
        };
    });
    var Cb, Db = {};
    function Eb(b, c) {
        var d, e = m(c.createElement(b)).appendTo(c.body), f = a.getDefaultComputedStyle && 
(d = a.getDefaultComputedStyle(e[0])) ? d.display : m.css(e[0], "display");
        return e.detach(), f;
    }
    function Fb(a) {
        var b = y, c = Db[a];
        return c || (c = Eb(a, b), "none" !== c && c || (Cb = (Cb || m("<iframe frameborder='0' width='0' height='0'/>")).appendTo(b.documentElement), b = (Cb[0].contentWindow || Cb[0].contentDocument).document, b.write(), b.close(), c = Eb(a, b), Cb.detach()), Db[a] = c), c;
    }
    !function() {
        var a;
        k.shrinkWrapBlocks = function() {
            if (null != a) return a;
            a = !1;
            var b, c, d;
            return c = y.getElementsByTagName("body")[0], c && c.style ? (b = y.createElement("div"), d = y.createElement("div"), d.style.cssText = "position:absolute;border:0;width:0;height:0;top:0;left:-9999px", c.appendChild(d).appendChild(b), typeof b.style.zoom !== K && (b.style.cssText = "-webkit-box-sizing:content-box;-moz-box-sizing:content-box;box-sizing:content-box;display:block;margin:0;border:0;padding:1px;width:1px;zoom:1"
, b.appendChild(y.createElement("div")).style.width = "5px", a = 3 !== b.offsetWidth), c.removeChild(d), a) : void 0;
        };
    }();
    var Gb = /^margin/, Hb = new RegExp("^(" + S + ")(?!px)[a-z%]+$", "i"), Ib, Jb, Kb = /^(top|right|bottom|left)$/;
    a.getComputedStyle ? (Ib = function(a) {
        return a.ownerDocument.defaultView.getComputedStyle(a, null);
    }, Jb = function(a, b, c) {
        var d, e, f, g, h = a.style;
        return c = c || Ib(a), g = c ? c.getPropertyValue(b) || c[b] : void 0, c && ("" !== g || m.contains(a.ownerDocument, a) || (g = m.style(a, b)), Hb.test(g) && Gb.test(b) && (d = h.width, e = h.minWidth, f = h.maxWidth, h.minWidth = h.maxWidth = h.width = g, g = c.width, h.width = d, h.minWidth = e, h.maxWidth = f)), void 0 === g ? g : g + "";
    }) : y.documentElement.currentStyle && (Ib = function(a) {
        return a.currentStyle;
    }, Jb = function(a, b, c) {
        var d, e, f, g, h = a.style;
        return c = c || Ib(a), g = c ? c[b] : void 0
, null == g && h && h[b] && (g = h[b]), Hb.test(g) && !Kb.test(b) && (d = h.left, e = a.runtimeStyle, f = e && e.left, f && (e.left = a.currentStyle.left), h.left = "fontSize" === b ? "1em" : g, g = h.pixelLeft + "px", h.left = d, f && (e.left = f)), void 0 === g ? g : g + "" || "auto";
    });
    function Lb(a, b) {
        return {
            get: function() {
                var c = a();
                if (null != c) return c ? void delete this.get : (this.get = b).apply(this, arguments);
            }
        };
    }
    !function() {
        var b, c, d, e, f, g, h;
        if (b = y.createElement("div"), b.innerHTML = "  <link/><table></table><a href='/a'>a</a><input type='checkbox'/>", d = b.getElementsByTagName("a")[0], c = d && d.style) {
            c.cssText = "float:left;opacity:.5", k.opacity = "0.5" === c.opacity, k.cssFloat = !!c.cssFloat, b.style.backgroundClip = "content-box", b.cloneNode(!0).style.backgroundClip = "", k.clearCloneStyle = "content-box" === b.style.backgroundClip
, k.boxSizing = "" === c.boxSizing || "" === c.MozBoxSizing || "" === c.WebkitBoxSizing, m.extend(k, {
                reliableHiddenOffsets: function() {
                    return null == g && i(), g;
                },
                boxSizingReliable: function() {
                    return null == f && i(), f;
                },
                pixelPosition: function() {
                    return null == e && i(), e;
                },
                reliableMarginRight: function() {
                    return null == h && i(), h;
                }
            });
            function i() {
                var b, c, d, i;
                c = y.getElementsByTagName("body")[0], c && c.style && (b = y.createElement("div"), d = y.createElement("div"), d.style.cssText = "position:absolute;border:0;width:0;height:0;top:0;left:-9999px", c.appendChild(d).appendChild(b), b.style.cssText = "-webkit-box-sizing:border-box;-moz-box-sizing:border-box;box-sizing:border-box;display:block;margin-top:1%;top:1%;border:1px;padding:1px;width:4px;position:absolute"
, e = f = !1, h = !0, a.getComputedStyle && (e = "1%" !== (a.getComputedStyle(b, null) || {}).top, f = "4px" === (a.getComputedStyle(b, null) || {
                    width: "4px"
                }).width, i = b.appendChild(y.createElement("div")), i.style.cssText = b.style.cssText = "-webkit-box-sizing:content-box;-moz-box-sizing:content-box;box-sizing:content-box;display:block;margin:0;border:0;padding:0", i.style.marginRight = i.style.width = "0", b.style.width = "1px", h = !parseFloat((a.getComputedStyle(i, null) || {}).marginRight)), b.innerHTML = "<table><tr><td></td><td>t</td></tr></table>", i = b.getElementsByTagName("td"), i[0].style.cssText = "margin:0;border:0;padding:0;display:none", g = 0 === i[0].offsetHeight, g && (i[0].style.display = "", i[1].style.display = "none", g = 0 === i[0].offsetHeight), c.removeChild(d));
            }
        }
    }(), m.swap = function(a, b, c, d) {
        var e, f, g = {};
        for (f in b) g[f] = a.style[f], a.style[f] = b[f];
        
e = c.apply(a, d || []);
        for (f in b) a.style[f] = g[f];
        return e;
    };
    var Mb = /alpha\([^)]*\)/i, Nb = /opacity\s*=\s*([^)]*)/, Ob = /^(none|table(?!-c[ea]).+)/, Pb = new RegExp("^(" + S + ")(.*)$", "i"), Qb = new RegExp("^([+-])=(" + S + ")", "i"), Rb = {
        position: "absolute",
        visibility: "hidden",
        display: "block"
    }, Sb = {
        letterSpacing: "0",
        fontWeight: "400"
    }, Tb = [ "Webkit", "O", "Moz", "ms" ];
    function Ub(a, b) {
        if (b in a) return b;
        var c = b.charAt(0).toUpperCase() + b.slice(1), d = b, e = Tb.length;
        while (e--) if (b = Tb[e] + c, b in a) return b;
        return d;
    }
    function Vb(a, b) {
        for (var c, d, e, f = [], g = 0, h = a.length; h > g; g++) d = a[g], d.style && (f[g] = m._data(d, "olddisplay"), c = d.style.display, b ? (f[g] || "none" !== c || (d.style.display = ""), "" === d.style.display && U(d) && (f[g] = m._data(d, "olddisplay", Fb(d.nodeName)))) : (e = 
U(d), (c && "none" !== c || !e) && m._data(d, "olddisplay", e ? c : m.css(d, "display"))));
        for (g = 0; h > g; g++) d = a[g], d.style && (b && "none" !== d.style.display && "" !== d.style.display || (d.style.display = b ? f[g] || "" : "none"));
        return a;
    }
    function Wb(a, b, c) {
        var d = Pb.exec(b);
        return d ? Math.max(0, d[1] - (c || 0)) + (d[2] || "px") : b;
    }
    function Xb(a, b, c, d, e) {
        for (var f = c === (d ? "border" : "content") ? 4 : "width" === b ? 1 : 0, g = 0; 4 > f; f += 2) "margin" === c && (g += m.css(a, c + T[f], !0, e)), d ? ("content" === c && (g -= m.css(a, "padding" + T[f], !0, e)), "margin" !== c && (g -= m.css(a, "border" + T[f] + "Width", !0, e))) : (g += m.css(a, "padding" + T[f], !0, e), "padding" !== c && (g += m.css(a, "border" + T[f] + "Width", !0, e)));
        return g;
    }
    function Yb(a, b, c) {
        var d = !0, e = "width" === b ? a.offsetWidth : a.offsetHeight, f = Ib(a), g = k.boxSizing && "border-box" === 
m.css(a, "boxSizing", !1, f);
        if (0 >= e || null == e) {
            if (e = Jb(a, b, f), (0 > e || null == e) && (e = a.style[b]), Hb.test(e)) return e;
            d = g && (k.boxSizingReliable() || e === a.style[b]), e = parseFloat(e) || 0;
        }
        return e + Xb(a, b, c || (g ? "border" : "content"), d, f) + "px";
    }
    m.extend({
        cssHooks: {
            opacity: {
                get: function(a, b) {
                    if (b) {
                        var c = Jb(a, "opacity");
                        return "" === c ? "1" : c;
                    }
                }
            }
        },
        cssNumber: {
            columnCount: !0,
            fillOpacity: !0,
            flexGrow: !0,
            flexShrink: !0,
            fontWeight: !0,
            lineHeight: !0,
            opacity: !0,
            order: !0,
            orphans: !0,
            widows: !0,
            zIndex: !0,
            zoom: !0
        },
        cssProps: {
            "float"
: k.cssFloat ? "cssFloat" : "styleFloat"
        },
        style: function(a, b, c, d) {
            if (a && 3 !== a.nodeType && 8 !== a.nodeType && a.style) {
                var e, f, g, h = m.camelCase(b), i = a.style;
                if (b = m.cssProps[h] || (m.cssProps[h] = Ub(i, h)), g = m.cssHooks[b] || m.cssHooks[h], void 0 === c) return g && "get" in g && void 0 !== (e = g.get(a, !1, d)) ? e : i[b];
                if (f = typeof c, "string" === f && (e = Qb.exec(c)) && (c = (e[1] + 1) * e[2] + parseFloat(m.css(a, b)), f = "number"), null != c && c === c && ("number" !== f || m.cssNumber[h] || (c += "px"), k.clearCloneStyle || "" !== c || 0 !== b.indexOf("background") || (i[b] = "inherit"), !(g && "set" in g && void 0 === (c = g.set(a, c, d))))) try {
                    i[b] = c;
                } catch (j) {}
            }
        },
        css: function(a, b, c, d) {
            var e, f, g, h = m.camelCase(b);
            return b = m.cssProps[h] || (m.cssProps[h] = Ub(a
.style, h)), g = m.cssHooks[b] || m.cssHooks[h], g && "get" in g && (f = g.get(a, !0, c)), void 0 === f && (f = Jb(a, b, d)), "normal" === f && b in Sb && (f = Sb[b]), "" === c || c ? (e = parseFloat(f), c === !0 || m.isNumeric(e) ? e || 0 : f) : f;
        }
    }), m.each([ "height", "width" ], function(a, b) {
        m.cssHooks[b] = {
            get: function(a, c, d) {
                return c ? Ob.test(m.css(a, "display")) && 0 === a.offsetWidth ? m.swap(a, Rb, function() {
                    return Yb(a, b, d);
                }) : Yb(a, b, d) : void 0;
            },
            set: function(a, c, d) {
                var e = d && Ib(a);
                return Wb(a, c, d ? Xb(a, b, d, k.boxSizing && "border-box" === m.css(a, "boxSizing", !1, e), e) : 0);
            }
        };
    }), k.opacity || (m.cssHooks.opacity = {
        get: function(a, b) {
            return Nb.test((b && a.currentStyle ? a.currentStyle.filter : a.style.filter) || "") ? .01 * parseFloat(RegExp.$1
) + "" : b ? "1" : "";
        },
        set: function(a, b) {
            var c = a.style, d = a.currentStyle, e = m.isNumeric(b) ? "alpha(opacity=" + 100 * b + ")" : "", f = d && d.filter || c.filter || "";
            c.zoom = 1, (b >= 1 || "" === b) && "" === m.trim(f.replace(Mb, "")) && c.removeAttribute && (c.removeAttribute("filter"), "" === b || d && !d.filter) || (c.filter = Mb.test(f) ? f.replace(Mb, e) : f + " " + e);
        }
    }), m.cssHooks.marginRight = Lb(k.reliableMarginRight, function(a, b) {
        return b ? m.swap(a, {
            display: "inline-block"
        }, Jb, [ a, "marginRight" ]) : void 0;
    }), m.each({
        margin: "",
        padding: "",
        border: "Width"
    }, function(a, b) {
        m.cssHooks[a + b] = {
            expand: function(c) {
                for (var d = 0, e = {}, f = "string" == typeof c ? c.split(" ") : [ c ]; 4 > d; d++) e[a + T[d] + b] = f[d] || f[d - 2] || f[0];
                return e;
            }
        }, Gb
.test(a) || (m.cssHooks[a + b].set = Wb);
    }), m.fn.extend({
        css: function(a, b) {
            return V(this, function(a, b, c) {
                var d, e, f = {}, g = 0;
                if (m.isArray(b)) {
                    for (d = Ib(a), e = b.length; e > g; g++) f[b[g]] = m.css(a, b[g], !1, d);
                    return f;
                }
                return void 0 !== c ? m.style(a, b, c) : m.css(a, b);
            }, a, b, arguments.length > 1);
        },
        show: function() {
            return Vb(this, !0);
        },
        hide: function() {
            return Vb(this);
        },
        toggle: function(a) {
            return "boolean" == typeof a ? a ? this.show() : this.hide() : this.each(function() {
                U(this) ? m(this).show() : m(this).hide();
            });
        }
    });
    function Zb(a, b, c, d, e) {
        return new Zb.prototype.init(a, b, c, d, e);
    }
    m.Tween = Zb, Zb.prototype = {
        constructor: Zb,
        
init: function(a, b, c, d, e, f) {
            this.elem = a, this.prop = c, this.easing = e || "swing", this.options = b, this.start = this.now = this.cur(), this.end = d, this.unit = f || (m.cssNumber[c] ? "" : "px");
        },
        cur: function() {
            var a = Zb.propHooks[this.prop];
            return a && a.get ? a.get(this) : Zb.propHooks._default.get(this);
        },
        run: function(a) {
            var b, c = Zb.propHooks[this.prop];
            return this.pos = b = this.options.duration ? m.easing[this.easing](a, this.options.duration * a, 0, 1, this.options.duration) : a, this.now = (this.end - this.start) * b + this.start, this.options.step && this.options.step.call(this.elem, this.now, this), c && c.set ? c.set(this) : Zb.propHooks._default.set(this), this;
        }
    }, Zb.prototype.init.prototype = Zb.prototype, Zb.propHooks = {
        _default: {
            get: function(a) {
                var b;
                return null == a.elem[a.prop] || 
a.elem.style && null != a.elem.style[a.prop] ? (b = m.css(a.elem, a.prop, ""), b && "auto" !== b ? b : 0) : a.elem[a.prop];
            },
            set: function(a) {
                m.fx.step[a.prop] ? m.fx.step[a.prop](a) : a.elem.style && (null != a.elem.style[m.cssProps[a.prop]] || m.cssHooks[a.prop]) ? m.style(a.elem, a.prop, a.now + a.unit) : a.elem[a.prop] = a.now;
            }
        }
    }, Zb.propHooks.scrollTop = Zb.propHooks.scrollLeft = {
        set: function(a) {
            a.elem.nodeType && a.elem.parentNode && (a.elem[a.prop] = a.now);
        }
    }, m.easing = {
        linear: function(a) {
            return a;
        },
        swing: function(a) {
            return .5 - Math.cos(a * Math.PI) / 2;
        }
    }, m.fx = Zb.prototype.init, m.fx.step = {};
    var $b, _b, ac = /^(?:toggle|show|hide)$/, bc = new RegExp("^(?:([+-])=|)(" + S + ")([a-z%]*)$", "i"), cc = /queueHooks$/, dc = [ ic ], ec = {
        "*": [ function(a, b) {
            var c = this
.createTween(a, b), d = c.cur(), e = bc.exec(b), f = e && e[3] || (m.cssNumber[a] ? "" : "px"), g = (m.cssNumber[a] || "px" !== f && +d) && bc.exec(m.css(c.elem, a)), h = 1, i = 20;
            if (g && g[3] !== f) {
                f = f || g[3], e = e || [], g = +d || 1;
                do h = h || ".5", g /= h, m.style(c.elem, a, g + f); while (h !== (h = c.cur() / d) && 1 !== h && --i);
            }
            return e && (g = c.start = +g || +d || 0, c.unit = f, c.end = e[1] ? g + (e[1] + 1) * e[2] : +e[2]), c;
        } ]
    };
    function fc() {
        return setTimeout(function() {
            $b = void 0;
        }), $b = m.now();
    }
    function gc(a, b) {
        var c, d = {
            height: a
        }, e = 0;
        for (b = b ? 1 : 0; 4 > e; e += 2 - b) c = T[e], d["margin" + c] = d["padding" + c] = a;
        return b && (d.opacity = d.width = a), d;
    }
    function hc(a, b, c) {
        for (var d, e = (ec[b] || []).concat(ec["*"]), f = 0, g = e.length; g > 
f; f++) if (d = e[f].call(c, b, a)) return d;
    }
    function ic(a, b, c) {
        var d, e, f, g, h, i, j, l, n = this, o = {}, p = a.style, q = a.nodeType && U(a), r = m._data(a, "fxshow");
        c.queue || (h = m._queueHooks(a, "fx"), null == h.unqueued && (h.unqueued = 0, i = h.empty.fire, h.empty.fire = function() {
            h.unqueued || i();
        }), h.unqueued++, n.always(function() {
            n.always(function() {
                h.unqueued--, m.queue(a, "fx").length || h.empty.fire();
            });
        })), 1 === a.nodeType && ("height" in b || "width" in b) && (c.overflow = [ p.overflow, p.overflowX, p.overflowY ], j = m.css(a, "display"), l = "none" === j ? m._data(a, "olddisplay") || Fb(a.nodeName) : j, "inline" === l && "none" === m.css(a, "float") && (k.inlineBlockNeedsLayout && "inline" !== Fb(a.nodeName) ? p.zoom = 1 : p.display = "inline-block")), c.overflow && (p.overflow = "hidden", k.shrinkWrapBlocks() || n.always(function() {
            p.overflow = 
c.overflow[0], p.overflowX = c.overflow[1], p.overflowY = c.overflow[2];
        }));
        for (d in b) if (e = b[d], ac.exec(e)) {
            if (delete b[d], f = f || "toggle" === e, e === (q ? "hide" : "show")) {
                if ("show" !== e || !r || void 0 === r[d]) continue;
                q = !0;
            }
            o[d] = r && r[d] || m.style(a, d);
        } else j = void 0;
        if (m.isEmptyObject(o)) "inline" === ("none" === j ? Fb(a.nodeName) : j) && (p.display = j); else {
            r ? "hidden" in r && (q = r.hidden) : r = m._data(a, "fxshow", {}), f && (r.hidden = !q), q ? m(a).show() : n.done(function() {
                m(a).hide();
            }), n.done(function() {
                var b;
                m._removeData(a, "fxshow");
                for (b in o) m.style(a, b, o[b]);
            });
            for (d in o) g = hc(q ? r[d] : 0, d, n), d in r || (r[d] = g.start, q && (g.end = g.start, g.start = "width" === d || "height" === d ? 1 : 0))
;
        }
    }
    function jc(a, b) {
        var c, d, e, f, g;
        for (c in a) if (d = m.camelCase(c), e = b[d], f = a[c], m.isArray(f) && (e = f[1], f = a[c] = f[0]), c !== d && (a[d] = f, delete a[c]), g = m.cssHooks[d], g && "expand" in g) {
            f = g.expand(f), delete a[d];
            for (c in f) c in a || (a[c] = f[c], b[c] = e);
        } else b[d] = e;
    }
    function kc(a, b, c) {
        var d, e, f = 0, g = dc.length, h = m.Deferred().always(function() {
            delete i.elem;
        }), i = function() {
            if (e) return !1;
            for (var b = $b || fc(), c = Math.max(0, j.startTime + j.duration - b), d = c / j.duration || 0, f = 1 - d, g = 0, i = j.tweens.length; i > g; g++) j.tweens[g].run(f);
            return h.notifyWith(a, [ j, f, c ]), 1 > f && i ? c : (h.resolveWith(a, [ j ]), !1);
        }, j = h.promise({
            elem: a,
            props: m.extend({}, b),
            opts: m.extend(!0, {
                specialEasing
: {}
            }, c),
            originalProperties: b,
            originalOptions: c,
            startTime: $b || fc(),
            duration: c.duration,
            tweens: [],
            createTween: function(b, c) {
                var d = m.Tween(a, j.opts, b, c, j.opts.specialEasing[b] || j.opts.easing);
                return j.tweens.push(d), d;
            },
            stop: function(b) {
                var c = 0, d = b ? j.tweens.length : 0;
                if (e) return this;
                for (e = !0; d > c; c++) j.tweens[c].run(1);
                return b ? h.resolveWith(a, [ j, b ]) : h.rejectWith(a, [ j, b ]), this;
            }
        }), k = j.props;
        for (jc(k, j.opts.specialEasing); g > f; f++) if (d = dc[f].call(j, a, k, j.opts)) return d;
        return m.map(k, hc, j), m.isFunction(j.opts.start) && j.opts.start.call(a, j), m.fx.timer(m.extend(i, {
            elem: a,
            anim: j,
            queue: j.opts.queue
        })), j.progress(
j.opts.progress).done(j.opts.done, j.opts.complete).fail(j.opts.fail).always(j.opts.always);
    }
    m.Animation = m.extend(kc, {
        tweener: function(a, b) {
            m.isFunction(a) ? (b = a, a = [ "*" ]) : a = a.split(" ");
            for (var c, d = 0, e = a.length; e > d; d++) c = a[d], ec[c] = ec[c] || [], ec[c].unshift(b);
        },
        prefilter: function(a, b) {
            b ? dc.unshift(a) : dc.push(a);
        }
    }), m.speed = function(a, b, c) {
        var d = a && "object" == typeof a ? m.extend({}, a) : {
            complete: c || !c && b || m.isFunction(a) && a,
            duration: a,
            easing: c && b || b && !m.isFunction(b) && b
        };
        return d.duration = m.fx.off ? 0 : "number" == typeof d.duration ? d.duration : d.duration in m.fx.speeds ? m.fx.speeds[d.duration] : m.fx.speeds._default, (null == d.queue || d.queue === !0) && (d.queue = "fx"), d.old = d.complete, d.complete = function() {
            m.isFunction(d.old) && 
d.old.call(this), d.queue && m.dequeue(this, d.queue);
        }, d;
    }, m.fn.extend({
        fadeTo: function(a, b, c, d) {
            return this.filter(U).css("opacity", 0).show().end().animate({
                opacity: b
            }, a, c, d);
        },
        animate: function(a, b, c, d) {
            var e = m.isEmptyObject(a), f = m.speed(b, c, d), g = function() {
                var b = kc(this, m.extend({}, a), f);
                (e || m._data(this, "finish")) && b.stop(!0);
            };
            return g.finish = g, e || f.queue === !1 ? this.each(g) : this.queue(f.queue, g);
        },
        stop: function(a, b, c) {
            var d = function(a) {
                var b = a.stop;
                delete a.stop, b(c);
            };
            return "string" != typeof a && (c = b, b = a, a = void 0), b && a !== !1 && this.queue(a || "fx", []), this.each(function() {
                var b = !0, e = null != a && a + "queueHooks", f = m.timers, g = m._data(
this);
                if (e) g[e] && g[e].stop && d(g[e]); else for (e in g) g[e] && g[e].stop && cc.test(e) && d(g[e]);
                for (e = f.length; e--; ) f[e].elem !== this || null != a && f[e].queue !== a || (f[e].anim.stop(c), b = !1, f.splice(e, 1));
                (b || !c) && m.dequeue(this, a);
            });
        },
        finish: function(a) {
            return a !== !1 && (a = a || "fx"), this.each(function() {
                var b, c = m._data(this), d = c[a + "queue"], e = c[a + "queueHooks"], f = m.timers, g = d ? d.length : 0;
                for (c.finish = !0, m.queue(this, a, []), e && e.stop && e.stop.call(this, !0), b = f.length; b--; ) f[b].elem === this && f[b].queue === a && (f[b].anim.stop(!0), f.splice(b, 1));
                for (b = 0; g > b; b++) d[b] && d[b].finish && d[b].finish.call(this);
                delete c.finish;
            });
        }
    }), m.each([ "toggle", "show", "hide" ], function(a, b) {
        var c = m.fn[b];
        
m.fn[b] = function(a, d, e) {
            return null == a || "boolean" == typeof a ? c.apply(this, arguments) : this.animate(gc(b, !0), a, d, e);
        };
    }), m.each({
        slideDown: gc("show"),
        slideUp: gc("hide"),
        slideToggle: gc("toggle"),
        fadeIn: {
            opacity: "show"
        },
        fadeOut: {
            opacity: "hide"
        },
        fadeToggle: {
            opacity: "toggle"
        }
    }, function(a, b) {
        m.fn[a] = function(a, c, d) {
            return this.animate(b, a, c, d);
        };
    }), m.timers = [], m.fx.tick = function() {
        var a, b = m.timers, c = 0;
        for ($b = m.now(); c < b.length; c++) a = b[c], a() || b[c] !== a || b.splice(c--, 1);
        b.length || m.fx.stop(), $b = void 0;
    }, m.fx.timer = function(a) {
        m.timers.push(a), a() ? m.fx.start() : m.timers.pop();
    }, m.fx.interval = 13, m.fx.start = function() {
        _b || (_b = setInterval(m.fx.tick, m.fx.interval));
    
}, m.fx.stop = function() {
        clearInterval(_b), _b = null;
    }, m.fx.speeds = {
        slow: 600,
        fast: 200,
        _default: 400
    }, m.fn.delay = function(a, b) {
        return a = m.fx ? m.fx.speeds[a] || a : a, b = b || "fx", this.queue(b, function(b, c) {
            var d = setTimeout(b, a);
            c.stop = function() {
                clearTimeout(d);
            };
        });
    }, function() {
        var a, b, c, d, e;
        b = y.createElement("div"), b.setAttribute("className", "t"), b.innerHTML = "  <link/><table></table><a href='/a'>a</a><input type='checkbox'/>", d = b.getElementsByTagName("a")[0], c = y.createElement("select"), e = c.appendChild(y.createElement("option")), a = b.getElementsByTagName("input")[0], d.style.cssText = "top:1px", k.getSetAttribute = "t" !== b.className, k.style = /top/.test(d.getAttribute("style")), k.hrefNormalized = "/a" === d.getAttribute("href"), k.checkOn = !!a.value, k.optSelected = e.selected, k.enctype = !!
y.createElement("form").enctype, c.disabled = !0, k.optDisabled = !e.disabled, a = y.createElement("input"), a.setAttribute("value", ""), k.input = "" === a.getAttribute("value"), a.value = "t", a.setAttribute("type", "radio"), k.radioValue = "t" === a.value;
    }();
    var lc = /\r/g;
    m.fn.extend({
        val: function(a) {
            var b, c, d, e = this[0];
            if (arguments.length) return d = m.isFunction(a), this.each(function(c) {
                var e;
                1 === this.nodeType && (e = d ? a.call(this, c, m(this).val()) : a, null == e ? e = "" : "number" == typeof e ? e += "" : m.isArray(e) && (e = m.map(e, function(a) {
                    return null == a ? "" : a + "";
                })), b = m.valHooks[this.type] || m.valHooks[this.nodeName.toLowerCase()], b && "set" in b && void 0 !== b.set(this, e, "value") || (this.value = e));
            });
            if (e) return b = m.valHooks[e.type] || m.valHooks[e.nodeName.toLowerCase()], b && "get" in 
b && void 0 !== (c = b.get(e, "value")) ? c : (c = e.value, "string" == typeof c ? c.replace(lc, "") : null == c ? "" : c);
        }
    }), m.extend({
        valHooks: {
            option: {
                get: function(a) {
                    var b = m.find.attr(a, "value");
                    return null != b ? b : m.trim(m.text(a));
                }
            },
            select: {
                get: function(a) {
                    for (var b, c, d = a.options, e = a.selectedIndex, f = "select-one" === a.type || 0 > e, g = f ? null : [], h = f ? e + 1 : d.length, i = 0 > e ? h : f ? e : 0; h > i; i++) if (c = d[i], !(!c.selected && i !== e || (k.optDisabled ? c.disabled : null !== c.getAttribute("disabled")) || c.parentNode.disabled && m.nodeName(c.parentNode, "optgroup"))) {
                        if (b = m(c).val(), f) return b;
                        g.push(b);
                    }
                    return g;
                },
                set: function(a, 
b) {
                    var c, d, e = a.options, f = m.makeArray(b), g = e.length;
                    while (g--) if (d = e[g], m.inArray(m.valHooks.option.get(d), f) >= 0) try {
                        d.selected = c = !0;
                    } catch (h) {
                        d.scrollHeight;
                    } else d.selected = !1;
                    return c || (a.selectedIndex = -1), e;
                }
            }
        }
    }), m.each([ "radio", "checkbox" ], function() {
        m.valHooks[this] = {
            set: function(a, b) {
                return m.isArray(b) ? a.checked = m.inArray(m(a).val(), b) >= 0 : void 0;
            }
        }, k.checkOn || (m.valHooks[this].get = function(a) {
            return null === a.getAttribute("value") ? "on" : a.value;
        });
    });
    var mc, nc, oc = m.expr.attrHandle, pc = /^(?:checked|selected)$/i, qc = k.getSetAttribute, rc = k.input;
    m.fn.extend({
        attr: function(a, b) {
            return V(this
, m.attr, a, b, arguments.length > 1);
        },
        removeAttr: function(a) {
            return this.each(function() {
                m.removeAttr(this, a);
            });
        }
    }), m.extend({
        attr: function(a, b, c) {
            var d, e, f = a.nodeType;
            if (a && 3 !== f && 8 !== f && 2 !== f) return typeof a.getAttribute === K ? m.prop(a, b, c) : (1 === f && m.isXMLDoc(a) || (b = b.toLowerCase(), d = m.attrHooks[b] || (m.expr.match.bool.test(b) ? nc : mc)), void 0 === c ? d && "get" in d && null !== (e = d.get(a, b)) ? e : (e = m.find.attr(a, b), null == e ? void 0 : e) : null !== c ? d && "set" in d && void 0 !== (e = d.set(a, c, b)) ? e : (a.setAttribute(b, c + ""), c) : void m.removeAttr(a, b));
        },
        removeAttr: function(a, b) {
            var c, d, e = 0, f = b && b.match(E);
            if (f && 1 === a.nodeType) while (c = f[e++]) d = m.propFix[c] || c, m.expr.match.bool.test(c) ? rc && qc || !pc.test(c) ? a[d] = !1 : a[m.camelCase
("default-" + c)] = a[d] = !1 : m.attr(a, c, ""), a.removeAttribute(qc ? c : d);
        },
        attrHooks: {
            type: {
                set: function(a, b) {
                    if (!k.radioValue && "radio" === b && m.nodeName(a, "input")) {
                        var c = a.value;
                        return a.setAttribute("type", b), c && (a.value = c), b;
                    }
                }
            }
        }
    }), nc = {
        set: function(a, b, c) {
            return b === !1 ? m.removeAttr(a, c) : rc && qc || !pc.test(c) ? a.setAttribute(!qc && m.propFix[c] || c, c) : a[m.camelCase("default-" + c)] = a[c] = !0, c;
        }
    }, m.each(m.expr.match.bool.source.match(/\w+/g), function(a, b) {
        var c = oc[b] || m.find.attr;
        oc[b] = rc && qc || !pc.test(b) ? function(a, b, d) {
            var e, f;
            return d || (f = oc[b], oc[b] = e, e = null != c(a, b, d) ? b.toLowerCase() : null, oc[b] = f), e;
        } : function(a, b, c
) {
            return c ? void 0 : a[m.camelCase("default-" + b)] ? b.toLowerCase() : null;
        };
    }), rc && qc || (m.attrHooks.value = {
        set: function(a, b, c) {
            return m.nodeName(a, "input") ? void (a.defaultValue = b) : mc && mc.set(a, b, c);
        }
    }), qc || (mc = {
        set: function(a, b, c) {
            var d = a.getAttributeNode(c);
            return d || a.setAttributeNode(d = a.ownerDocument.createAttribute(c)), d.value = b += "", "value" === c || b === a.getAttribute(c) ? b : void 0;
        }
    }, oc.id = oc.name = oc.coords = function(a, b, c) {
        var d;
        return c ? void 0 : (d = a.getAttributeNode(b)) && "" !== d.value ? d.value : null;
    }, m.valHooks.button = {
        get: function(a, b) {
            var c = a.getAttributeNode(b);
            return c && c.specified ? c.value : void 0;
        },
        set: mc.set
    }, m.attrHooks.contenteditable = {
        set: function(a, b, c) {
            mc.set(a, "" === 
b ? !1 : b, c);
        }
    }, m.each([ "width", "height" ], function(a, b) {
        m.attrHooks[b] = {
            set: function(a, c) {
                return "" === c ? (a.setAttribute(b, "auto"), c) : void 0;
            }
        };
    })), k.style || (m.attrHooks.style = {
        get: function(a) {
            return a.style.cssText || void 0;
        },
        set: function(a, b) {
            return a.style.cssText = b + "";
        }
    });
    var sc = /^(?:input|select|textarea|button|object)$/i, tc = /^(?:a|area)$/i;
    m.fn.extend({
        prop: function(a, b) {
            return V(this, m.prop, a, b, arguments.length > 1);
        },
        removeProp: function(a) {
            return a = m.propFix[a] || a, this.each(function() {
                try {
                    this[a] = void 0, delete this[a];
                } catch (b) {}
            });
        }
    }), m.extend({
        propFix: {
            "for": "htmlFor",
            "class": "className"
        
},
        prop: function(a, b, c) {
            var d, e, f, g = a.nodeType;
            if (a && 3 !== g && 8 !== g && 2 !== g) return f = 1 !== g || !m.isXMLDoc(a), f && (b = m.propFix[b] || b, e = m.propHooks[b]), void 0 !== c ? e && "set" in e && void 0 !== (d = e.set(a, c, b)) ? d : a[b] = c : e && "get" in e && null !== (d = e.get(a, b)) ? d : a[b];
        },
        propHooks: {
            tabIndex: {
                get: function(a) {
                    var b = m.find.attr(a, "tabindex");
                    return b ? parseInt(b, 10) : sc.test(a.nodeName) || tc.test(a.nodeName) && a.href ? 0 : -1;
                }
            }
        }
    }), k.hrefNormalized || m.each([ "href", "src" ], function(a, b) {
        m.propHooks[b] = {
            get: function(a) {
                return a.getAttribute(b, 4);
            }
        };
    }), k.optSelected || (m.propHooks.selected = {
        get: function(a) {
            var b = a.parentNode;
            return b && (b.selectedIndex
, b.parentNode && b.parentNode.selectedIndex), null;
        }
    }), m.each([ "tabIndex", "readOnly", "maxLength", "cellSpacing", "cellPadding", "rowSpan", "colSpan", "useMap", "frameBorder", "contentEditable" ], function() {
        m.propFix[this.toLowerCase()] = this;
    }), k.enctype || (m.propFix.enctype = "encoding");
    var uc = /[\t\r\n\f]/g;
    m.fn.extend({
        addClass: function(a) {
            var b, c, d, e, f, g, h = 0, i = this.length, j = "string" == typeof a && a;
            if (m.isFunction(a)) return this.each(function(b) {
                m(this).addClass(a.call(this, b, this.className));
            });
            if (j) for (b = (a || "").match(E) || []; i > h; h++) if (c = this[h], d = 1 === c.nodeType && (c.className ? (" " + c.className + " ").replace(uc, " ") : " ")) {
                f = 0;
                while (e = b[f++]) d.indexOf(" " + e + " ") < 0 && (d += e + " ");
                g = m.trim(d), c.className !== g && (c.className = g);
            
}
            return this;
        },
        removeClass: function(a) {
            var b, c, d, e, f, g, h = 0, i = this.length, j = 0 === arguments.length || "string" == typeof a && a;
            if (m.isFunction(a)) return this.each(function(b) {
                m(this).removeClass(a.call(this, b, this.className));
            });
            if (j) for (b = (a || "").match(E) || []; i > h; h++) if (c = this[h], d = 1 === c.nodeType && (c.className ? (" " + c.className + " ").replace(uc, " ") : "")) {
                f = 0;
                while (e = b[f++]) while (d.indexOf(" " + e + " ") >= 0) d = d.replace(" " + e + " ", " ");
                g = a ? m.trim(d) : "", c.className !== g && (c.className = g);
            }
            return this;
        },
        toggleClass: function(a, b) {
            var c = typeof a;
            return "boolean" == typeof b && "string" === c ? b ? this.addClass(a) : this.removeClass(a) : this.each(m.isFunction(a) ? function(c) {
                
m(this).toggleClass(a.call(this, c, this.className, b), b);
            } : function() {
                if ("string" === c) {
                    var b, d = 0, e = m(this), f = a.match(E) || [];
                    while (b = f[d++]) e.hasClass(b) ? e.removeClass(b) : e.addClass(b);
                } else (c === K || "boolean" === c) && (this.className && m._data(this, "__className__", this.className), this.className = this.className || a === !1 ? "" : m._data(this, "__className__") || "");
            });
        },
        hasClass: function(a) {
            for (var b = " " + a + " ", c = 0, d = this.length; d > c; c++) if (1 === this[c].nodeType && (" " + this[c].className + " ").replace(uc, " ").indexOf(b) >= 0) return !0;
            return !1;
        }
    }), m.each("blur focus focusin focusout load resize scroll unload click dblclick mousedown mouseup mousemove mouseover mouseout mouseenter mouseleave change select submit keydown keypress keyup error contextmenu".split(" "), 
function(a, b) {
        m.fn[b] = function(a, c) {
            return arguments.length > 0 ? this.on(b, null, a, c) : this.trigger(b);
        };
    }), m.fn.extend({
        hover: function(a, b) {
            return this.mouseenter(a).mouseleave(b || a);
        },
        bind: function(a, b, c) {
            return this.on(a, null, b, c);
        },
        unbind: function(a, b) {
            return this.off(a, null, b);
        },
        delegate: function(a, b, c, d) {
            return this.on(b, a, c, d);
        },
        undelegate: function(a, b, c) {
            return 1 === arguments.length ? this.off(a, "**") : this.off(b, a || "**", c);
        }
    });
    var vc = m.now(), wc = /\?/, xc = /(,)|(\[|{)|(}|])|"(?:[^"\\\r\n]|\\["\\\/bfnrt]|\\u[\da-fA-F]{4})*"\s*:?|true|false|null|-?(?!0\d)\d+(?:\.\d+|)(?:[eE][+-]?\d+|)/g;
    m.parseJSON = function(b) {
        if (a.JSON && a.JSON.parse) return a.JSON.parse(b + "");
        var c, d = null, e = m.trim(b + "");
        
return e && !m.trim(e.replace(xc, function(a, b, e, f) {
            return c && b && (d = 0), 0 === d ? a : (c = e || b, d += !f - !e, "");
        })) ? Function("return " + e)() : m.error("Invalid JSON: " + b);
    }, m.parseXML = function(b) {
        var c, d;
        if (!b || "string" != typeof b) return null;
        try {
            a.DOMParser ? (d = new DOMParser, c = d.parseFromString(b, "text/xml")) : (c = new ActiveXObject("Microsoft.XMLDOM"), c.async = "false", c.loadXML(b));
        } catch (e) {
            c = void 0;
        }
        return c && c.documentElement && !c.getElementsByTagName("parsererror").length || m.error("Invalid XML: " + b), c;
    };
    var yc, zc, Ac = /#.*$/, Bc = /([?&])_=[^&]*/, Cc = /^(.*?):[ \t]*([^\r\n]*)\r?$/gm, Dc = /^(?:about|app|app-storage|.+-extension|file|res|widget):$/, Ec = /^(?:GET|HEAD)$/, Fc = /^\/\//, Gc = /^([\w.+-]+:)(?:\/\/(?:[^\/?#]*@|)([^\/?#:]*)(?::(\d+)|)|)/, Hc = {}, Ic = {}, Jc = "*/".concat("*");
    try {
        zc = 
location.href;
    } catch (Kc) {
        zc = y.createElement("a"), zc.href = "", zc = zc.href;
    }
    yc = Gc.exec(zc.toLowerCase()) || [];
    function Lc(a) {
        return function(b, c) {
            "string" != typeof b && (c = b, b = "*");
            var d, e = 0, f = b.toLowerCase().match(E) || [];
            if (m.isFunction(c)) while (d = f[e++]) "+" === d.charAt(0) ? (d = d.slice(1) || "*", (a[d] = a[d] || []).unshift(c)) : (a[d] = a[d] || []).push(c);
        };
    }
    function Mc(a, b, c, d) {
        var e = {}, f = a === Ic;
        function g(h) {
            var i;
            return e[h] = !0, m.each(a[h] || [], function(a, h) {
                var j = h(b, c, d);
                return "string" != typeof j || f || e[j] ? f ? !(i = j) : void 0 : (b.dataTypes.unshift(j), g(j), !1);
            }), i;
        }
        return g(b.dataTypes[0]) || !e["*"] && g("*");
    }
    function Nc(a, b) {
        var c, d, e = m.ajaxSettings.flatOptions || {};
        for (
d in b) void 0 !== b[d] && ((e[d] ? a : c || (c = {}))[d] = b[d]);
        return c && m.extend(!0, a, c), a;
    }
    function Oc(a, b, c) {
        var d, e, f, g, h = a.contents, i = a.dataTypes;
        while ("*" === i[0]) i.shift(), void 0 === e && (e = a.mimeType || b.getResponseHeader("Content-Type"));
        if (e) for (g in h) if (h[g] && h[g].test(e)) {
            i.unshift(g);
            break;
        }
        if (i[0] in c) f = i[0]; else {
            for (g in c) {
                if (!i[0] || a.converters[g + " " + i[0]]) {
                    f = g;
                    break;
                }
                d || (d = g);
            }
            f = f || d;
        }
        return f ? (f !== i[0] && i.unshift(f), c[f]) : void 0;
    }
    function Pc(a, b, c, d) {
        var e, f, g, h, i, j = {}, k = a.dataTypes.slice();
        if (k[1]) for (g in a.converters) j[g.toLowerCase()] = a.converters[g];
        f = k.shift();
        while (f) if (a.responseFields
[f] && (c[a.responseFields[f]] = b), !i && d && a.dataFilter && (b = a.dataFilter(b, a.dataType)), i = f, f = k.shift()) if ("*" === f) f = i; else if ("*" !== i && i !== f) {
            if (g = j[i + " " + f] || j["* " + f], !g) for (e in j) if (h = e.split(" "), h[1] === f && (g = j[i + " " + h[0]] || j["* " + h[0]])) {
                g === !0 ? g = j[e] : j[e] !== !0 && (f = h[0], k.unshift(h[1]));
                break;
            }
            if (g !== !0) if (g && a["throws"]) b = g(b); else try {
                b = g(b);
            } catch (l) {
                return {
                    state: "parsererror",
                    error: g ? l : "No conversion from " + i + " to " + f
                };
            }
        }
        return {
            state: "success",
            data: b
        };
    }
    m.extend({
        active: 0,
        lastModified: {},
        etag: {},
        ajaxSettings: {
            url: zc,
            type: "GET",
            isLocal: 
Dc.test(yc[1]),
            global: !0,
            processData: !0,
            async: !0,
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            accepts: {
                "*": Jc,
                text: "text/plain",
                html: "text/html",
                xml: "application/xml, text/xml",
                json: "application/json, text/javascript"
            },
            contents: {
                xml: /xml/,
                html: /html/,
                json: /json/
            },
            responseFields: {
                xml: "responseXML",
                text: "responseText",
                json: "responseJSON"
            },
            converters: {
                "* text": String,
                "text html": !0,
                "text json": m.parseJSON,
                "text xml": m.parseXML
            },
            flatOptions: {
                url: !0,
                context: !0
            }
        },
        ajaxSetup
: function(a, b) {
            return b ? Nc(Nc(a, m.ajaxSettings), b) : Nc(m.ajaxSettings, a);
        },
        ajaxPrefilter: Lc(Hc),
        ajaxTransport: Lc(Ic),
        ajax: function(a, b) {
            "object" == typeof a && (b = a, a = void 0), b = b || {};
            var c, d, e, f, g, h, i, j, k = m.ajaxSetup({}, b), l = k.context || k, n = k.context && (l.nodeType || l.jquery) ? m(l) : m.event, o = m.Deferred(), p = m.Callbacks("once memory"), q = k.statusCode || {}, r = {}, s = {}, t = 0, u = "canceled", v = {
                readyState: 0,
                getResponseHeader: function(a) {
                    var b;
                    if (2 === t) {
                        if (!j) {
                            j = {};
                            while (b = Cc.exec(f)) j[b[1].toLowerCase()] = b[2];
                        }
                        b = j[a.toLowerCase()];
                    }
                    return null == b ? null : b;
                },
                
getAllResponseHeaders: function() {
                    return 2 === t ? f : null;
                },
                setRequestHeader: function(a, b) {
                    var c = a.toLowerCase();
                    return t || (a = s[c] = s[c] || a, r[a] = b), this;
                },
                overrideMimeType: function(a) {
                    return t || (k.mimeType = a), this;
                },
                statusCode: function(a) {
                    var b;
                    if (a) if (2 > t) for (b in a) q[b] = [ q[b], a[b] ]; else v.always(a[v.status]);
                    return this;
                },
                abort: function(a) {
                    var b = a || u;
                    return i && i.abort(b), x(0, b), this;
                }
            };
            if (o.promise(v).complete = p.add, v.success = v.done, v.error = v.fail, k.url = ((a || k.url || zc) + "").replace(Ac, "").replace(Fc, yc[1] + "//"), k.type = b.method || b.type || k.method || 
k.type, k.dataTypes = m.trim(k.dataType || "*").toLowerCase().match(E) || [ "" ], null == k.crossDomain && (c = Gc.exec(k.url.toLowerCase()), k.crossDomain = !(!c || c[1] === yc[1] && c[2] === yc[2] && (c[3] || ("http:" === c[1] ? "80" : "443")) === (yc[3] || ("http:" === yc[1] ? "80" : "443")))), k.data && k.processData && "string" != typeof k.data && (k.data = m.param(k.data, k.traditional)), Mc(Hc, k, b, v), 2 === t) return v;
            h = k.global, h && 0 === m.active++ && m.event.trigger("ajaxStart"), k.type = k.type.toUpperCase(), k.hasContent = !Ec.test(k.type), e = k.url, k.hasContent || (k.data && (e = k.url += (wc.test(e) ? "&" : "?") + k.data, delete k.data), k.cache === !1 && (k.url = Bc.test(e) ? e.replace(Bc, "$1_=" + vc++) : e + (wc.test(e) ? "&" : "?") + "_=" + vc++)), k.ifModified && (m.lastModified[e] && v.setRequestHeader("If-Modified-Since", m.lastModified[e]), m.etag[e] && v.setRequestHeader("If-None-Match", m.etag[e])), (k.data && k.hasContent && k.contentType !== !1 || 
b.contentType) && v.setRequestHeader("Content-Type", k.contentType), v.setRequestHeader("Accept", k.dataTypes[0] && k.accepts[k.dataTypes[0]] ? k.accepts[k.dataTypes[0]] + ("*" !== k.dataTypes[0] ? ", " + Jc + "; q=0.01" : "") : k.accepts["*"]);
            for (d in k.headers) v.setRequestHeader(d, k.headers[d]);
            if (!k.beforeSend || k.beforeSend.call(l, v, k) !== !1 && 2 !== t) {
                u = "abort";
                for (d in {
                    success: 1,
                    error: 1,
                    complete: 1
                }) v[d](k[d]);
                if (i = Mc(Ic, k, b, v)) {
                    v.readyState = 1, h && n.trigger("ajaxSend", [ v, k ]), k.async && k.timeout > 0 && (g = setTimeout(function() {
                        v.abort("timeout");
                    }, k.timeout));
                    try {
                        t = 1, i.send(r, x);
                    } catch (w) {
                        if (!(2 > t)) throw w;
                        
x(-1, w);
                    }
                } else x(-1, "No Transport");
                function x(a, b, c, d) {
                    var j, r, s, u, w, x = b;
                    2 !== t && (t = 2, g && clearTimeout(g), i = void 0, f = d || "", v.readyState = a > 0 ? 4 : 0, j = a >= 200 && 300 > a || 304 === a, c && (u = Oc(k, v, c)), u = Pc(k, u, v, j), j ? (k.ifModified && (w = v.getResponseHeader("Last-Modified"), w && (m.lastModified[e] = w), w = v.getResponseHeader("etag"), w && (m.etag[e] = w)), 204 === a || "HEAD" === k.type ? x = "nocontent" : 304 === a ? x = "notmodified" : (x = u.state, r = u.data, s = u.error, j = !s)) : (s = x, (a || !x) && (x = "error", 0 > a && (a = 0))), v.status = a, v.statusText = (b || x) + "", j ? o.resolveWith(l, [ r, x, v ]) : o.rejectWith(l, [ v, x, s ]), v.statusCode(q), q = void 0, h && n.trigger(j ? "ajaxSuccess" : "ajaxError", [ v, k, j ? r : s ]), p.fireWith(l, [ v, x ]), h && (n.trigger("ajaxComplete", [ v, k ]), --m.active || m.event.trigger
("ajaxStop")));
                }
                return v;
            }
            return v.abort();
        },
        getJSON: function(a, b, c) {
            return m.get(a, b, c, "json");
        },
        getScript: function(a, b) {
            return m.get(a, void 0, b, "script");
        }
    }), m.each([ "get", "post" ], function(a, b) {
        m[b] = function(a, c, d, e) {
            return m.isFunction(c) && (e = e || d, d = c, c = void 0), m.ajax({
                url: a,
                type: b,
                dataType: e,
                data: c,
                success: d
            });
        };
    }), m.each([ "ajaxStart", "ajaxStop", "ajaxComplete", "ajaxError", "ajaxSuccess", "ajaxSend" ], function(a, b) {
        m.fn[b] = function(a) {
            return this.on(b, a);
        };
    }), m._evalUrl = function(a) {
        return m.ajax({
            url: a,
            type: "GET",
            dataType: "script",
            async: !1,
            global: !1
,
            "throws": !0
        });
    }, m.fn.extend({
        wrapAll: function(a) {
            if (m.isFunction(a)) return this.each(function(b) {
                m(this).wrapAll(a.call(this, b));
            });
            if (this[0]) {
                var b = m(a, this[0].ownerDocument).eq(0).clone(!0);
                this[0].parentNode && b.insertBefore(this[0]), b.map(function() {
                    var a = this;
                    while (a.firstChild && 1 === a.firstChild.nodeType) a = a.firstChild;
                    return a;
                }).append(this);
            }
            return this;
        },
        wrapInner: function(a) {
            return this.each(m.isFunction(a) ? function(b) {
                m(this).wrapInner(a.call(this, b));
            } : function() {
                var b = m(this), c = b.contents();
                c.length ? c.wrapAll(a) : b.append(a);
            });
        },
        wrap: function(a) {
            var b = m.isFunction
(a);
            return this.each(function(c) {
                m(this).wrapAll(b ? a.call(this, c) : a);
            });
        },
        unwrap: function() {
            return this.parent().each(function() {
                m.nodeName(this, "body") || m(this).replaceWith(this.childNodes);
            }).end();
        }
    }), m.expr.filters.hidden = function(a) {
        return a.offsetWidth <= 0 && a.offsetHeight <= 0 || !k.reliableHiddenOffsets() && "none" === (a.style && a.style.display || m.css(a, "display"));
    }, m.expr.filters.visible = function(a) {
        return !m.expr.filters.hidden(a);
    };
    var Qc = /%20/g, Rc = /\[\]$/, Sc = /\r?\n/g, Tc = /^(?:submit|button|image|reset|file)$/i, Uc = /^(?:input|select|textarea|keygen)/i;
    function Vc(a, b, c, d) {
        var e;
        if (m.isArray(b)) m.each(b, function(b, e) {
            c || Rc.test(a) ? d(a, e) : Vc(a + "[" + ("object" == typeof e ? b : "") + "]", e, c, d);
        }); else if (c || "object" !== m
.type(b)) d(a, b); else for (e in b) Vc(a + "[" + e + "]", b[e], c, d);
    }
    m.param = function(a, b) {
        var c, d = [], e = function(a, b) {
            b = m.isFunction(b) ? b() : null == b ? "" : b, d[d.length] = encodeURIComponent(a) + "=" + encodeURIComponent(b);
        };
        if (void 0 === b && (b = m.ajaxSettings && m.ajaxSettings.traditional), m.isArray(a) || a.jquery && !m.isPlainObject(a)) m.each(a, function() {
            e(this.name, this.value);
        }); else for (c in a) Vc(c, a[c], b, e);
        return d.join("&").replace(Qc, "+");
    }, m.fn.extend({
        serialize: function() {
            return m.param(this.serializeArray());
        },
        serializeArray: function() {
            return this.map(function() {
                var a = m.prop(this, "elements");
                return a ? m.makeArray(a) : this;
            }).filter(function() {
                var a = this.type;
                return this.name && !m(this).is(":disabled") && 
Uc.test(this.nodeName) && !Tc.test(a) && (this.checked || !W.test(a));
            }).map(function(a, b) {
                var c = m(this).val();
                return null == c ? null : m.isArray(c) ? m.map(c, function(a) {
                    return {
                        name: b.name,
                        value: a.replace(Sc, "\r\n")
                    };
                }) : {
                    name: b.name,
                    value: c.replace(Sc, "\r\n")
                };
            }).get();
        }
    }), m.ajaxSettings.xhr = void 0 !== a.ActiveXObject ? function() {
        return !this.isLocal && /^(get|post|head|put|delete|options)$/i.test(this.type) && Zc() || $c();
    } : Zc;
    var Wc = 0, Xc = {}, Yc = m.ajaxSettings.xhr();
    a.ActiveXObject && m(a).on("unload", function() {
        for (var a in Xc) Xc[a](void 0, !0);
    }), k.cors = !!Yc && "withCredentials" in Yc, Yc = k.ajax = !!Yc, Yc && m.ajaxTransport(function(a) {
        if (!a.crossDomain || 
k.cors) {
            var b;
            return {
                send: function(c, d) {
                    var e, f = a.xhr(), g = ++Wc;
                    if (f.open(a.type, a.url, a.async, a.username, a.password), a.xhrFields) for (e in a.xhrFields) f[e] = a.xhrFields[e];
                    a.mimeType && f.overrideMimeType && f.overrideMimeType(a.mimeType), a.crossDomain || c["X-Requested-With"] || (c["X-Requested-With"] = "XMLHttpRequest");
                    for (e in c) void 0 !== c[e] && f.setRequestHeader(e, c[e] + "");
                    f.send(a.hasContent && a.data || null), b = function(c, e) {
                        var h, i, j;
                        if (b && (e || 4 === f.readyState)) if (delete Xc[g], b = void 0, f.onreadystatechange = m.noop, e) 4 !== f.readyState && f.abort(); else {
                            j = {}, h = f.status, "string" == typeof f.responseText && (j.text = f.responseText);
                            try {
                                i = 
f.statusText;
                            } catch (k) {
                                i = "";
                            }
                            h || !a.isLocal || a.crossDomain ? 1223 === h && (h = 204) : h = j.text ? 200 : 404;
                        }
                        j && d(h, i, j, f.getAllResponseHeaders());
                    }, a.async ? 4 === f.readyState ? setTimeout(b) : f.onreadystatechange = Xc[g] = b : b();
                },
                abort: function() {
                    b && b(void 0, !0);
                }
            };
        }
    });
    function Zc() {
        try {
            return new a.XMLHttpRequest;
        } catch (b) {}
    }
    function $c() {
        try {
            return new a.ActiveXObject("Microsoft.XMLHTTP");
        } catch (b) {}
    }
    m.ajaxSetup({
        accepts: {
            script: "text/javascript, application/javascript, application/ecmascript, application/x-ecmascript"
        },
        contents: {
            
script: /(?:java|ecma)script/
        },
        converters: {
            "text script": function(a) {
                return m.globalEval(a), a;
            }
        }
    }), m.ajaxPrefilter("script", function(a) {
        void 0 === a.cache && (a.cache = !1), a.crossDomain && (a.type = "GET", a.global = !1);
    }), m.ajaxTransport("script", function(a) {
        if (a.crossDomain) {
            var b, c = y.head || m("head")[0] || y.documentElement;
            return {
                send: function(d, e) {
                    b = y.createElement("script"), b.async = !0, a.scriptCharset && (b.charset = a.scriptCharset), b.src = a.url, b.onload = b.onreadystatechange = function(a, c) {
                        (c || !b.readyState || /loaded|complete/.test(b.readyState)) && (b.onload = b.onreadystatechange = null, b.parentNode && b.parentNode.removeChild(b), b = null, c || e(200, "success"));
                    }, c.insertBefore(b, c.firstChild);
                },
                
abort: function() {
                    b && b.onload(void 0, !0);
                }
            };
        }
    });
    var _c = [], ad = /(=)\?(?=&|$)|\?\?/;
    m.ajaxSetup({
        jsonp: "callback",
        jsonpCallback: function() {
            var a = _c.pop() || m.expando + "_" + vc++;
            return this[a] = !0, a;
        }
    }), m.ajaxPrefilter("json jsonp", function(b, c, d) {
        var e, f, g, h = b.jsonp !== !1 && (ad.test(b.url) ? "url" : "string" == typeof b.data && !(b.contentType || "").indexOf("application/x-www-form-urlencoded") && ad.test(b.data) && "data");
        return h || "jsonp" === b.dataTypes[0] ? (e = b.jsonpCallback = m.isFunction(b.jsonpCallback) ? b.jsonpCallback() : b.jsonpCallback, h ? b[h] = b[h].replace(ad, "$1" + e) : b.jsonp !== !1 && (b.url += (wc.test(b.url) ? "&" : "?") + b.jsonp + "=" + e), b.converters["script json"] = function() {
            return g || m.error(e + " was not called"), g[0];
        }, b.dataTypes[0] = "json", f = 
a[e], a[e] = function() {
            g = arguments;
        }, d.always(function() {
            a[e] = f, b[e] && (b.jsonpCallback = c.jsonpCallback, _c.push(e)), g && m.isFunction(f) && f(g[0]), g = f = void 0;
        }), "script") : void 0;
    }), m.parseHTML = function(a, b, c) {
        if (!a || "string" != typeof a) return null;
        "boolean" == typeof b && (c = b, b = !1), b = b || y;
        var d = u.exec(a), e = !c && [];
        return d ? [ b.createElement(d[1]) ] : (d = m.buildFragment([ a ], b, e), e && e.length && m(e).remove(), m.merge([], d.childNodes));
    };
    var bd = m.fn.load;
    m.fn.load = function(a, b, c) {
        if ("string" != typeof a && bd) return bd.apply(this, arguments);
        var d, e, f, g = this, h = a.indexOf(" ");
        return h >= 0 && (d = m.trim(a.slice(h, a.length)), a = a.slice(0, h)), m.isFunction(b) ? (c = b, b = void 0) : b && "object" == typeof b && (f = "POST"), g.length > 0 && m.ajax({
            url: a,
            type
: f,
            dataType: "html",
            data: b
        }).done(function(a) {
            e = arguments, g.html(d ? m("<div>").append(m.parseHTML(a)).find(d) : a);
        }).complete(c && function(a, b) {
            g.each(c, e || [ a.responseText, b, a ]);
        }), this;
    }, m.expr.filters.animated = function(a) {
        return m.grep(m.timers, function(b) {
            return a === b.elem;
        }).length;
    };
    var cd = a.document.documentElement;
    function dd(a) {
        return m.isWindow(a) ? a : 9 === a.nodeType ? a.defaultView || a.parentWindow : !1;
    }
    m.offset = {
        setOffset: function(a, b, c) {
            var d, e, f, g, h, i, j, k = m.css(a, "position"), l = m(a), n = {};
            "static" === k && (a.style.position = "relative"), h = l.offset(), f = m.css(a, "top"), i = m.css(a, "left"), j = ("absolute" === k || "fixed" === k) && m.inArray("auto", [ f, i ]) > -1, j ? (d = l.position(), g = d.top, e = d.left) : (g = parseFloat(f) || 0
, e = parseFloat(i) || 0), m.isFunction(b) && (b = b.call(a, c, h)), null != b.top && (n.top = b.top - h.top + g), null != b.left && (n.left = b.left - h.left + e), "using" in b ? b.using.call(a, n) : l.css(n);
        }
    }, m.fn.extend({
        offset: function(a) {
            if (arguments.length) return void 0 === a ? this : this.each(function(b) {
                m.offset.setOffset(this, a, b);
            });
            var b, c, d = {
                top: 0,
                left: 0
            }, e = this[0], f = e && e.ownerDocument;
            if (f) return b = f.documentElement, m.contains(b, e) ? (typeof e.getBoundingClientRect !== K && (d = e.getBoundingClientRect()), c = dd(f), {
                top: d.top + (c.pageYOffset || b.scrollTop) - (b.clientTop || 0),
                left: d.left + (c.pageXOffset || b.scrollLeft) - (b.clientLeft || 0)
            }) : d;
        },
        position: function() {
            if (this[0]) {
                var a, b, c = {
                    
top: 0,
                    left: 0
                }, d = this[0];
                return "fixed" === m.css(d, "position") ? b = d.getBoundingClientRect() : (a = this.offsetParent(), b = this.offset(), m.nodeName(a[0], "html") || (c = a.offset()), c.top += m.css(a[0], "borderTopWidth", !0), c.left += m.css(a[0], "borderLeftWidth", !0)), {
                    top: b.top - c.top - m.css(d, "marginTop", !0),
                    left: b.left - c.left - m.css(d, "marginLeft", !0)
                };
            }
        },
        offsetParent: function() {
            return this.map(function() {
                var a = this.offsetParent || cd;
                while (a && !m.nodeName(a, "html") && "static" === m.css(a, "position")) a = a.offsetParent;
                return a || cd;
            });
        }
    }), m.each({
        scrollLeft: "pageXOffset",
        scrollTop: "pageYOffset"
    }, function(a, b) {
        var c = /Y/.test(b);
        m.fn[a] = function(d) {
            return V
(this, function(a, d, e) {
                var f = dd(a);
                return void 0 === e ? f ? b in f ? f[b] : f.document.documentElement[d] : a[d] : void (f ? f.scrollTo(c ? m(f).scrollLeft() : e, c ? e : m(f).scrollTop()) : a[d] = e);
            }, a, d, arguments.length, null);
        };
    }), m.each([ "top", "left" ], function(a, b) {
        m.cssHooks[b] = Lb(k.pixelPosition, function(a, c) {
            return c ? (c = Jb(a, b), Hb.test(c) ? m(a).position()[b] + "px" : c) : void 0;
        });
    }), m.each({
        Height: "height",
        Width: "width"
    }, function(a, b) {
        m.each({
            padding: "inner" + a,
            content: b,
            "": "outer" + a
        }, function(c, d) {
            m.fn[d] = function(d, e) {
                var f = arguments.length && (c || "boolean" != typeof d), g = c || (d === !0 || e === !0 ? "margin" : "border");
                return V(this, function(b, c, d) {
                    var e;
                    
return m.isWindow(b) ? b.document.documentElement["client" + a] : 9 === b.nodeType ? (e = b.documentElement, Math.max(b.body["scroll" + a], e["scroll" + a], b.body["offset" + a], e["offset" + a], e["client" + a])) : void 0 === d ? m.css(b, c, g) : m.style(b, c, d, g);
                }, b, f ? d : void 0, f, null);
            };
        });
    }), m.fn.size = function() {
        return this.length;
    }, m.fn.andSelf = m.fn.addBack, "function" == typeof define && define.amd && define("jquery", [], function() {
        return m;
    });
    var ed = a.jQuery, fd = a.$;
    return m.noConflict = function(b) {
        return a.$ === m && (a.$ = fd), b && a.jQuery === m && (a.jQuery = ed), m;
    }, typeof b === K && (a.jQuery = a.$ = m), m;
});

var Prototype = {
    Version: "1.7.1",
    Browser: function() {
        var ua = navigator.userAgent, isOpera = Object.prototype.toString.call(window.opera) == "[object Opera]";
        return {
            IE: !!window.attachEvent && !isOpera
,
            Opera: isOpera,
            WebKit: ua.indexOf("AppleWebKit/") > -1,
            Gecko: ua.indexOf("Gecko") > -1 && ua.indexOf("KHTML") === -1,
            MobileSafari: /Apple.*Mobile/.test(ua)
        };
    }(),
    BrowserFeatures: {
        XPath: !!document.evaluate,
        SelectorsAPI: !!document.querySelector,
        ElementExtensions: function() {
            var constructor = window.Element || window.HTMLElement;
            return !!constructor && !!constructor.prototype;
        }(),
        SpecificElementExtensions: function() {
            if (typeof window.HTMLDivElement != "undefined") return !0;
            var div = document.createElement("div"), form = document.createElement("form"), isSupported = !1;
            return div.__proto__ && div.__proto__ !== form.__proto__ && (isSupported = !0), div = form = null, isSupported;
        }()
    },
    ScriptFragment: "<script[^>]*>([\\S\\s]*?)</script\\s*>",
    JSONFilter: /^\/\*-secure-([\s\S]*)\*\/\s*$/
,
    emptyFunction: function() {},
    K: function(x) {
        return x;
    }
};

Prototype.Browser.MobileSafari && (Prototype.BrowserFeatures.SpecificElementExtensions = !1);

var Class = function() {
    var IS_DONTENUM_BUGGY = function() {
        for (var p in {
            toString: 1
        }) if (p === "toString") return !1;
        return !0;
    }();
    function subclass() {}
    function create() {
        var parent = null, properties = $A(arguments);
        Object.isFunction(properties[0]) && (parent = properties.shift());
        function klass() {
            this.initialize.apply(this, arguments);
        }
        Object.extend(klass, Class.Methods), klass.superclass = parent, klass.subclasses = [], parent && (subclass.prototype = parent.prototype, klass.prototype = new subclass, parent.subclasses.push(klass));
        for (var i = 0, length = properties.length; i < length; i++) klass.addMethods(properties[i]);
        return klass.prototype.initialize || (klass.prototype
.initialize = Prototype.emptyFunction), klass.prototype.constructor = klass, klass;
    }
    function addMethods(source) {
        var ancestor = this.superclass && this.superclass.prototype, properties = Object.keys(source);
        IS_DONTENUM_BUGGY && (source.toString != Object.prototype.toString && properties.push("toString"), source.valueOf != Object.prototype.valueOf && properties.push("valueOf"));
        for (var i = 0, length = properties.length; i < length; i++) {
            var property = properties[i], value = source[property];
            if (ancestor && Object.isFunction(value) && value.argumentNames()[0] == "$super") {
                var method = value;
                value = function(m) {
                    return function() {
                        return ancestor[m].apply(this, arguments);
                    };
                }(property).wrap(method), value.valueOf = function(method) {
                    return function() {
                        return method
.valueOf.call(method);
                    };
                }(method), value.toString = function(method) {
                    return function() {
                        return method.toString.call(method);
                    };
                }(method);
            }
            this.prototype[property] = value;
        }
        return this;
    }
    return {
        create: create,
        Methods: {
            addMethods: addMethods
        }
    };
}();

(function() {
    var _toString = Object.prototype.toString, _hasOwnProperty = Object.prototype.hasOwnProperty, NULL_TYPE = "Null", UNDEFINED_TYPE = "Undefined", BOOLEAN_TYPE = "Boolean", NUMBER_TYPE = "Number", STRING_TYPE = "String", OBJECT_TYPE = "Object", FUNCTION_CLASS = "[object Function]", BOOLEAN_CLASS = "[object Boolean]", NUMBER_CLASS = "[object Number]", STRING_CLASS = "[object String]", ARRAY_CLASS = "[object Array]", DATE_CLASS = "[object Date]", NATIVE_JSON_STRINGIFY_SUPPORT = window.JSON && typeof JSON.stringify == "function" && 
JSON.stringify(0) === "0" && typeof JSON.stringify(Prototype.K) == "undefined", DONT_ENUMS = [ "toString", "toLocaleString", "valueOf", "hasOwnProperty", "isPrototypeOf", "propertyIsEnumerable", "constructor" ], IS_DONTENUM_BUGGY = function() {
        for (var p in {
            toString: 1
        }) if (p === "toString") return !1;
        return !0;
    }();
    function Type(o) {
        switch (o) {
          case null:
            return NULL_TYPE;
          case void 0:
            return UNDEFINED_TYPE;
        }
        var type = typeof o;
        switch (type) {
          case "boolean":
            return BOOLEAN_TYPE;
          case "number":
            return NUMBER_TYPE;
          case "string":
            return STRING_TYPE;
        }
        return OBJECT_TYPE;
    }
    function extend(destination, source) {
        for (var property in source) destination[property] = source[property];
        return destination;
    }
    function inspect(object) {
        try {
            
return isUndefined(object) ? "undefined" : object === null ? "null" : object.inspect ? object.inspect() : String(object);
        } catch (e) {
            if (e instanceof RangeError) return "...";
            throw e;
        }
    }
    function toJSON(value) {
        return Str("", {
            "": value
        }, []);
    }
    function Str(key, holder, stack) {
        var value = holder[key];
        Type(value) === OBJECT_TYPE && typeof value.toJSON == "function" && (value = value.toJSON(key));
        var _class = _toString.call(value);
        switch (_class) {
          case NUMBER_CLASS:
          case BOOLEAN_CLASS:
          case STRING_CLASS:
            value = value.valueOf();
        }
        switch (value) {
          case null:
            return "null";
          case !0:
            return "true";
          case !1:
            return "false";
        }
        var type = typeof value;
        switch (type) {
          case "string":
            return value.inspect
(!0);
          case "number":
            return isFinite(value) ? String(value) : "null";
          case "object":
            for (var i = 0, length = stack.length; i < length; i++) if (stack[i] === value) throw new TypeError("Cyclic reference to '" + value + "' in object");
            stack.push(value);
            var partial = [];
            if (_class === ARRAY_CLASS) {
                for (var i = 0, length = value.length; i < length; i++) {
                    var str = Str(i, value, stack);
                    partial.push(typeof str == "undefined" ? "null" : str);
                }
                partial = "[" + partial.join(",") + "]";
            } else {
                var keys = Object.keys(value);
                for (var i = 0, length = keys.length; i < length; i++) {
                    var key = keys[i], str = Str(key, value, stack);
                    typeof str != "undefined" && partial.push(key.inspect(!0) + ":" + str);
                }
                partial = "{" + 
partial.join(",") + "}";
            }
            return stack.pop(), partial;
        }
    }
    function stringify(object) {
        return JSON.stringify(object);
    }
    function toQueryString(object) {
        return $H(object).toQueryString();
    }
    function toHTML(object) {
        return object && object.toHTML ? object.toHTML() : String.interpret(object);
    }
    function keys(object) {
        if (Type(object) !== OBJECT_TYPE) throw new TypeError;
        var results = [];
        for (var property in object) _hasOwnProperty.call(object, property) && results.push(property);
        if (IS_DONTENUM_BUGGY) for (var i = 0; property = DONT_ENUMS[i]; i++) _hasOwnProperty.call(object, property) && results.push(property);
        return results;
    }
    function values(object) {
        var results = [];
        for (var property in object) results.push(object[property]);
        return results;
    }
    function clone(object) {
        return extend({}, object);
    }
    
function isElement(object) {
        return !!object && object.nodeType == 1;
    }
    function isArray(object) {
        return _toString.call(object) === ARRAY_CLASS;
    }
    var hasNativeIsArray = typeof Array.isArray == "function" && Array.isArray([]) && !Array.isArray({});
    hasNativeIsArray && (isArray = Array.isArray);
    function isHash(object) {
        return object instanceof Hash;
    }
    function isFunction(object) {
        return _toString.call(object) === FUNCTION_CLASS;
    }
    function isString(object) {
        return _toString.call(object) === STRING_CLASS;
    }
    function isNumber(object) {
        return _toString.call(object) === NUMBER_CLASS;
    }
    function isDate(object) {
        return _toString.call(object) === DATE_CLASS;
    }
    function isUndefined(object) {
        return typeof object == "undefined";
    }
    extend(Object, {
        extend: extend,
        inspect: inspect,
        toJSON: NATIVE_JSON_STRINGIFY_SUPPORT ? stringify : 
toJSON,
        toQueryString: toQueryString,
        toHTML: toHTML,
        keys: Object.keys || keys,
        values: values,
        clone: clone,
        isElement: isElement,
        isArray: isArray,
        isHash: isHash,
        isFunction: isFunction,
        isString: isString,
        isNumber: isNumber,
        isDate: isDate,
        isUndefined: isUndefined
    });
})(), Object.extend(Function.prototype, function() {
    var slice = Array.prototype.slice;
    function update(array, args) {
        var arrayLength = array.length, length = args.length;
        while (length--) array[arrayLength + length] = args[length];
        return array;
    }
    function merge(array, args) {
        return array = slice.call(array, 0), update(array, args);
    }
    function argumentNames() {
        var names = this.toString().match(/^[\s\(]*function[^(]*\(([^)]*)\)/)[1].replace(/\/\/.*?[\r\n]|\/\*(?:.|[\r\n])*?\*\//g, "").replace(/\s+/g, "").split(",");
        return names.length == 1 && !
names[0] ? [] : names;
    }
    function bind(context) {
        if (arguments.length < 2 && Object.isUndefined(arguments[0])) return this;
        if (!Object.isFunction(this)) throw new TypeError("The object is not callable.");
        var nop = function() {}, __method = this, args = slice.call(arguments, 1), bound = function() {
            var a = merge(args, arguments), c = context, c = this instanceof bound ? this : context;
            return __method.apply(c, a);
        };
        return nop.prototype = this.prototype, bound.prototype = new nop, bound;
    }
    function bindAsEventListener(context) {
        var __method = this, args = slice.call(arguments, 1);
        return function(event) {
            var a = update([ event || window.event ], args);
            return __method.apply(context, a);
        };
    }
    function curry() {
        if (!arguments.length) return this;
        var __method = this, args = slice.call(arguments, 0);
        return function() {
            
var a = merge(args, arguments);
            return __method.apply(this, a);
        };
    }
    function delay(timeout) {
        var __method = this, args = slice.call(arguments, 1);
        return timeout *= 1e3, window.setTimeout(function() {
            return __method.apply(__method, args);
        }, timeout);
    }
    function defer() {
        var args = update([ .01 ], arguments);
        return this.delay.apply(this, args);
    }
    function wrap(wrapper) {
        var __method = this;
        return function() {
            var a = update([ __method.bind(this) ], arguments);
            return wrapper.apply(this, a);
        };
    }
    function methodize() {
        if (this._methodized) return this._methodized;
        var __method = this;
        return this._methodized = function() {
            var a = update([ this ], arguments);
            return __method.apply(null, a);
        };
    }
    var extensions = {
        argumentNames: argumentNames,
        bindAsEventListener
: bindAsEventListener,
        curry: curry,
        delay: delay,
        defer: defer,
        wrap: wrap,
        methodize: methodize
    };
    return Function.prototype.bind || (extensions.bind = bind), extensions;
}()), function(proto) {
    function toISOString() {
        return this.getUTCFullYear() + "-" + (this.getUTCMonth() + 1).toPaddedString(2) + "-" + this.getUTCDate().toPaddedString(2) + "T" + this.getUTCHours().toPaddedString(2) + ":" + this.getUTCMinutes().toPaddedString(2) + ":" + this.getUTCSeconds().toPaddedString(2) + "Z";
    }
    function toJSON() {
        return this.toISOString();
    }
    proto.toISOString || (proto.toISOString = toISOString), proto.toJSON || (proto.toJSON = toJSON);
}(Date.prototype), RegExp.prototype.match = RegExp.prototype.test, RegExp.escape = function(str) {
    return String(str).replace(/([.*+?^=!:${}()|[\]\/\\])/g, "\\$1");
};

var PeriodicalExecuter = Class.create({
    initialize: function(callback, frequency) {
        this.callback = 
callback, this.frequency = frequency, this.currentlyExecuting = !1, this.registerCallback();
    },
    registerCallback: function() {
        this.timer = setInterval(this.onTimerEvent.bind(this), this.frequency * 1e3);
    },
    execute: function() {
        this.callback(this);
    },
    stop: function() {
        if (!this.timer) return;
        clearInterval(this.timer), this.timer = null;
    },
    onTimerEvent: function() {
        if (!this.currentlyExecuting) try {
            this.currentlyExecuting = !0, this.execute(), this.currentlyExecuting = !1;
        } catch (e) {
            throw this.currentlyExecuting = !1, e;
        }
    }
});

Object.extend(String, {
    interpret: function(value) {
        return value == null ? "" : String(value);
    },
    specialChar: {
        "\b": "\\b",
        "	": "\\t",
        "\n": "\\n",
        "\f": "\\f",
        "\r": "\\r",
        "\\": "\\\\"
    }
}), Object.extend(String.prototype, function() {
    var NATIVE_JSON_PARSE_SUPPORT = 
window.JSON && typeof JSON.parse == "function" && JSON.parse('{"test": true}').test;
    function prepareReplacement(replacement) {
        if (Object.isFunction(replacement)) return replacement;
        var template = new Template(replacement);
        return function(match) {
            return template.evaluate(match);
        };
    }
    function gsub(pattern, replacement) {
        var result = "", source = this, match;
        replacement = prepareReplacement(replacement), Object.isString(pattern) && (pattern = RegExp.escape(pattern));
        if (!pattern.length && !pattern.source) return replacement = replacement(""), replacement + source.split("").join(replacement) + replacement;
        while (source.length > 0) (match = source.match(pattern)) ? (result += source.slice(0, match.index), result += String.interpret(replacement(match)), source = source.slice(match.index + match[0].length)) : (result += source, source = "");
        return result;
    }
    function sub(pattern, replacement
, count) {
        return replacement = prepareReplacement(replacement), count = Object.isUndefined(count) ? 1 : count, this.gsub(pattern, function(match) {
            return --count < 0 ? match[0] : replacement(match);
        });
    }
    function scan(pattern, iterator) {
        return this.gsub(pattern, iterator), String(this);
    }
    function truncate(length, truncation) {
        return length = length || 30, truncation = Object.isUndefined(truncation) ? "..." : truncation, this.length > length ? this.slice(0, length - truncation.length) + truncation : String(this);
    }
    function strip() {
        return this.replace(/^\s+/, "").replace(/\s+$/, "");
    }
    function stripTags() {
        return this.replace(/<\w+(\s+("[^"]*"|'[^']*'|[^>])+)?>|<\/\w+>/gi, "");
    }
    function stripScripts() {
        return this.replace(new RegExp(Prototype.ScriptFragment, "img"), "");
    }
    function extractScripts() {
        var matchAll = new RegExp(Prototype.ScriptFragment, "img"
), matchOne = new RegExp(Prototype.ScriptFragment, "im");
        return (this.match(matchAll) || []).map(function(scriptTag) {
            return (scriptTag.match(matchOne) || [ "", "" ])[1];
        });
    }
    function evalScripts() {
        return this.extractScripts().map(function(script) {
            return eval(script);
        });
    }
    function escapeHTML() {
        return this.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
    }
    function unescapeHTML() {
        return this.stripTags().replace(/&lt;/g, "<").replace(/&gt;/g, ">").replace(/&amp;/g, "&");
    }
    function toQueryParams(separator) {
        var match = this.strip().match(/([^?#]*)(#.*)?$/);
        return match ? match[1].split(separator || "&").inject({}, function(hash, pair) {
            if ((pair = pair.split("="))[0]) {
                var key = decodeURIComponent(pair.shift()), value = pair.length > 1 ? pair.join("=") : pair[0];
                value != undefined && (value = 
decodeURIComponent(value)), key in hash ? (Object.isArray(hash[key]) || (hash[key] = [ hash[key] ]), hash[key].push(value)) : hash[key] = value;
            }
            return hash;
        }) : {};
    }
    function toArray() {
        return this.split("");
    }
    function succ() {
        return this.slice(0, this.length - 1) + String.fromCharCode(this.charCodeAt(this.length - 1) + 1);
    }
    function times(count) {
        return count < 1 ? "" : (new Array(count + 1)).join(this);
    }
    function camelize() {
        return this.replace(/-+(.)?/g, function(match, chr) {
            return chr ? chr.toUpperCase() : "";
        });
    }
    function capitalize() {
        return this.charAt(0).toUpperCase() + this.substring(1).toLowerCase();
    }
    function underscore() {
        return this.replace(/::/g, "/").replace(/([A-Z]+)([A-Z][a-z])/g, "$1_$2").replace(/([a-z\d])([A-Z])/g, "$1_$2").replace(/-/g, "_").toLowerCase();
    }
    function dasherize() {
        return this
.replace(/_/g, "-");
    }
    function inspect(useDoubleQuotes) {
        var escapedString = this.replace(/[\x00-\x1f\\]/g, function(character) {
            return character in String.specialChar ? String.specialChar[character] : "\\u00" + character.charCodeAt().toPaddedString(2, 16);
        });
        return useDoubleQuotes ? '"' + escapedString.replace(/"/g, '\\"') + '"' : "'" + escapedString.replace(/'/g, "\\'") + "'";
    }
    function unfilterJSON(filter) {
        return this.replace(filter || Prototype.JSONFilter, "$1");
    }
    function isJSON() {
        var str = this;
        return str.blank() ? !1 : (str = str.replace(/\\(?:["\\\/bfnrt]|u[0-9a-fA-F]{4})/g, "@"), str = str.replace(/"[^"\\\n\r]*"|true|false|null|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?/g, "]"), str = str.replace(/(?:^|:|,)(?:\s*\[)+/g, ""), /^[\],:{}\s]*$/.test(str));
    }
    function evalJSON(sanitize) {
        var json = this.unfilterJSON(), cx = /[\u0000\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g
;
        cx.test(json) && (json = json.replace(cx, function(a) {
            return "\\u" + ("0000" + a.charCodeAt(0).toString(16)).slice(-4);
        }));
        try {
            if (!sanitize || json.isJSON()) return eval("(" + json + ")");
        } catch (e) {}
        throw new SyntaxError("Badly formed JSON string: " + this.inspect());
    }
    function parseJSON() {
        var json = this.unfilterJSON();
        return JSON.parse(json);
    }
    function include(pattern) {
        return this.indexOf(pattern) > -1;
    }
    function startsWith(pattern) {
        return this.lastIndexOf(pattern, 0) === 0;
    }
    function endsWith(pattern) {
        var d = this.length - pattern.length;
        return d >= 0 && this.indexOf(pattern, d) === d;
    }
    function empty() {
        return this == "";
    }
    function blank() {
        return /^\s*$/.test(this);
    }
    function interpolate(object, pattern) {
        return (new Template(this, pattern)).evaluate(object);
    
}
    return {
        gsub: gsub,
        sub: sub,
        scan: scan,
        truncate: truncate,
        strip: String.prototype.trim || strip,
        stripTags: stripTags,
        stripScripts: stripScripts,
        extractScripts: extractScripts,
        evalScripts: evalScripts,
        escapeHTML: escapeHTML,
        unescapeHTML: unescapeHTML,
        toQueryParams: toQueryParams,
        parseQuery: toQueryParams,
        toArray: toArray,
        succ: succ,
        times: times,
        camelize: camelize,
        capitalize: capitalize,
        underscore: underscore,
        dasherize: dasherize,
        inspect: inspect,
        unfilterJSON: unfilterJSON,
        isJSON: isJSON,
        evalJSON: NATIVE_JSON_PARSE_SUPPORT ? parseJSON : evalJSON,
        include: include,
        startsWith: startsWith,
        endsWith: endsWith,
        empty: empty,
        blank: blank,
        interpolate: interpolate
    };
}());

var Template = Class.create({
    initialize: function(
template, pattern) {
        this.template = template.toString(), this.pattern = pattern || Template.Pattern;
    },
    evaluate: function(object) {
        return object && Object.isFunction(object.toTemplateReplacements) && (object = object.toTemplateReplacements()), this.template.gsub(this.pattern, function(match) {
            if (object == null) return match[1] + "";
            var before = match[1] || "";
            if (before == "\\") return match[2];
            var ctx = object, expr = match[3], pattern = /^([^.[]+|\[((?:.*?[^\\])?)\])(\.|\[|$)/;
            match = pattern.exec(expr);
            if (match == null) return before;
            while (match != null) {
                var comp = match[1].startsWith("[") ? match[2].replace(/\\\\]/g, "]") : match[1];
                ctx = ctx[comp];
                if (null == ctx || "" == match[3]) break;
                expr = expr.substring("[" == match[3] ? match[1].length : match[0].length), match = pattern.exec(expr);
            
}
            return before + String.interpret(ctx);
        });
    }
});

Template.Pattern = /(^|.|\r|\n)(#\{(.*?)\})/;

var $break = {}, Enumerable = function() {
    function each(iterator, context) {
        try {
            this._each(iterator, context);
        } catch (e) {
            if (e != $break) throw e;
        }
        return this;
    }
    function eachSlice(number, iterator, context) {
        var index = -number, slices = [], array = this.toArray();
        if (number < 1) return array;
        while ((index += number) < array.length) slices.push(array.slice(index, index + number));
        return slices.collect(iterator, context);
    }
    function all(iterator, context) {
        iterator = iterator || Prototype.K;
        var result = !0;
        return this.each(function(value, index) {
            result = result && !!iterator.call(context, value, index, this);
            if (!result) throw $break;
        }, this), result;
    }
    function any(iterator, 
context) {
        iterator = iterator || Prototype.K;
        var result = !1;
        return this.each(function(value, index) {
            if (result = !!iterator.call(context, value, index, this)) throw $break;
        }, this), result;
    }
    function collect(iterator, context) {
        iterator = iterator || Prototype.K;
        var results = [];
        return this.each(function(value, index) {
            results.push(iterator.call(context, value, index, this));
        }, this), results;
    }
    function detect(iterator, context) {
        var result;
        return this.each(function(value, index) {
            if (iterator.call(context, value, index, this)) throw result = value, $break;
        }, this), result;
    }
    function findAll(iterator, context) {
        var results = [];
        return this.each(function(value, index) {
            iterator.call(context, value, index, this) && results.push(value);
        }, this), results;
    }
    function grep(filter, 
iterator, context) {
        iterator = iterator || Prototype.K;
        var results = [];
        return Object.isString(filter) && (filter = new RegExp(RegExp.escape(filter))), this.each(function(value, index) {
            filter.match(value) && results.push(iterator.call(context, value, index, this));
        }, this), results;
    }
    function include(object) {
        if (Object.isFunction(this.indexOf) && this.indexOf(object) != -1) return !0;
        var found = !1;
        return this.each(function(value) {
            if (value == object) throw found = !0, $break;
        }), found;
    }
    function inGroupsOf(number, fillWith) {
        return fillWith = Object.isUndefined(fillWith) ? null : fillWith, this.eachSlice(number, function(slice) {
            while (slice.length < number) slice.push(fillWith);
            return slice;
        });
    }
    function inject(memo, iterator, context) {
        return this.each(function(value, index) {
            memo = iterator.call
(context, memo, value, index, this);
        }, this), memo;
    }
    function invoke(method) {
        var args = $A(arguments).slice(1);
        return this.map(function(value) {
            return value[method].apply(value, args);
        });
    }
    function max(iterator, context) {
        iterator = iterator || Prototype.K;
        var result;
        return this.each(function(value, index) {
            value = iterator.call(context, value, index, this);
            if (result == null || value >= result) result = value;
        }, this), result;
    }
    function min(iterator, context) {
        iterator = iterator || Prototype.K;
        var result;
        return this.each(function(value, index) {
            value = iterator.call(context, value, index, this);
            if (result == null || value < result) result = value;
        }, this), result;
    }
    function partition(iterator, context) {
        iterator = iterator || Prototype.K;
        var trues = [], falses = 
[];
        return this.each(function(value, index) {
            (iterator.call(context, value, index, this) ? trues : falses).push(value);
        }, this), [ trues, falses ];
    }
    function pluck(property) {
        var results = [];
        return this.each(function(value) {
            results.push(value[property]);
        }), results;
    }
    function reject(iterator, context) {
        var results = [];
        return this.each(function(value, index) {
            iterator.call(context, value, index, this) || results.push(value);
        }, this), results;
    }
    function sortBy(iterator, context) {
        return this.map(function(value, index) {
            return {
                value: value,
                criteria: iterator.call(context, value, index, this)
            };
        }, this).sort(function(left, right) {
            var a = left.criteria, b = right.criteria;
            return a < b ? -1 : a > b ? 1 : 0;
        }).pluck("value");
    }
    function toArray
() {
        return this.map();
    }
    function zip() {
        var iterator = Prototype.K, args = $A(arguments);
        Object.isFunction(args.last()) && (iterator = args.pop());
        var collections = [ this ].concat(args).map($A);
        return this.map(function(value, index) {
            return iterator(collections.pluck(index));
        });
    }
    function size() {
        return this.toArray().length;
    }
    function inspect() {
        return "#<Enumerable:" + this.toArray().inspect() + ">";
    }
    return {
        each: each,
        eachSlice: eachSlice,
        all: all,
        every: all,
        any: any,
        some: any,
        collect: collect,
        map: collect,
        detect: detect,
        findAll: findAll,
        select: findAll,
        filter: findAll,
        grep: grep,
        include: include,
        member: include,
        inGroupsOf: inGroupsOf,
        inject: inject,
        invoke: invoke,
        max: max,
        min: min,
        
partition: partition,
        pluck: pluck,
        reject: reject,
        sortBy: sortBy,
        toArray: toArray,
        entries: toArray,
        zip: zip,
        size: size,
        inspect: inspect,
        find: detect
    };
}();

function $A(iterable) {
    if (!iterable) return [];
    if ("toArray" in Object(iterable)) return iterable.toArray();
    var length = iterable.length || 0, results = new Array(length);
    while (length--) results[length] = iterable[length];
    return results;
}

function $w(string) {
    return Object.isString(string) ? (string = string.strip(), string ? string.split(/\s+/) : []) : [];
}

Array.from = $A, function() {
    var arrayProto = Array.prototype, slice = arrayProto.slice, _each = arrayProto.forEach;
    function each(iterator, context) {
        for (var i = 0, length = this.length >>> 0; i < length; i++) i in this && iterator.call(context, this[i], i, this);
    }
    _each || (_each = each);
    function clear() {
        return this
.length = 0, this;
    }
    function first() {
        return this[0];
    }
    function last() {
        return this[this.length - 1];
    }
    function compact() {
        return this.select(function(value) {
            return value != null;
        });
    }
    function flatten() {
        return this.inject([], function(array, value) {
            return Object.isArray(value) ? array.concat(value.flatten()) : (array.push(value), array);
        });
    }
    function without() {
        var values = slice.call(arguments, 0);
        return this.select(function(value) {
            return !values.include(value);
        });
    }
    function reverse(inline) {
        return (inline === !1 ? this.toArray() : this)._reverse();
    }
    function uniq(sorted) {
        return this.inject([], function(array, value, index) {
            return (0 == index || (sorted ? array.last() != value : !array.include(value))) && array.push(value), array;
        });
    }
    function intersect
(array) {
        return this.uniq().findAll(function(item) {
            return array.indexOf(item) !== -1;
        });
    }
    function clone() {
        return slice.call(this, 0);
    }
    function size() {
        return this.length;
    }
    function inspect() {
        return "[" + this.map(Object.inspect).join(", ") + "]";
    }
    function indexOf(item, i) {
        if (this == null) throw new TypeError;
        var array = Object(this), length = array.length >>> 0;
        if (length === 0) return -1;
        i = Number(i), isNaN(i) ? i = 0 : i !== 0 && isFinite(i) && (i = (i > 0 ? 1 : -1) * Math.floor(Math.abs(i)));
        if (i > length) return -1;
        var k = i >= 0 ? i : Math.max(length - Math.abs(i), 0);
        for (; k < length; k++) if (k in array && array[k] === item) return k;
        return -1;
    }
    function lastIndexOf(item, i) {
        if (this == null) throw new TypeError;
        var array = Object(this), length = array.length >>> 0;
        if (
length === 0) return -1;
        Object.isUndefined(i) ? i = length : (i = Number(i), isNaN(i) ? i = 0 : i !== 0 && isFinite(i) && (i = (i > 0 ? 1 : -1) * Math.floor(Math.abs(i))));
        var k = i >= 0 ? Math.min(i, length - 1) : length - Math.abs(i);
        for (; k >= 0; k--) if (k in array && array[k] === item) return k;
        return -1;
    }
    function concat(_) {
        var array = [], items = slice.call(arguments, 0), item, n = 0;
        items.unshift(this);
        for (var i = 0, length = items.length; i < length; i++) {
            item = items[i];
            if (!Object.isArray(item) || "callee" in item) array[n++] = item; else for (var j = 0, arrayLength = item.length; j < arrayLength; j++) j in item && (array[n] = item[j]), n++;
        }
        return array.length = n, array;
    }
    function wrapNative(method) {
        return function() {
            if (arguments.length === 0) return method.call(this, Prototype.K);
            if (arguments[0] === undefined
) {
                var args = slice.call(arguments, 1);
                return args.unshift(Prototype.K), method.apply(this, args);
            }
            return method.apply(this, arguments);
        };
    }
    function map(iterator) {
        if (this == null) throw new TypeError;
        iterator = iterator || Prototype.K;
        var object = Object(this), results = [], context = arguments[1], n = 0;
        for (var i = 0, length = object.length >>> 0; i < length; i++) i in object && (results[n] = iterator.call(context, object[i], i, object)), n++;
        return results.length = n, results;
    }
    arrayProto.map && (map = wrapNative(Array.prototype.map));
    function filter(iterator) {
        if (this == null || !Object.isFunction(iterator)) throw new TypeError;
        var object = Object(this), results = [], context = arguments[1], value;
        for (var i = 0, length = object.length >>> 0; i < length; i++) i in object && (value = object[i], iterator.call(context, value
, i, object) && results.push(value));
        return results;
    }
    arrayProto.filter && (filter = Array.prototype.filter);
    function some(iterator) {
        if (this == null) throw new TypeError;
        iterator = iterator || Prototype.K;
        var context = arguments[1], object = Object(this);
        for (var i = 0, length = object.length >>> 0; i < length; i++) if (i in object && iterator.call(context, object[i], i, object)) return !0;
        return !1;
    }
    if (arrayProto.some) var some = wrapNative(Array.prototype.some);
    function every(iterator) {
        if (this == null) throw new TypeError;
        iterator = iterator || Prototype.K;
        var context = arguments[1], object = Object(this);
        for (var i = 0, length = object.length >>> 0; i < length; i++) if (i in object && !iterator.call(context, object[i], i, object)) return !1;
        return !0;
    }
    if (arrayProto.every) var every = wrapNative(Array.prototype.every);
    var _reduce = arrayProto
.reduce;
    function inject(memo, iterator) {
        iterator = iterator || Prototype.K;
        var context = arguments[2];
        return _reduce.call(this, iterator.bind(context), memo);
    }
    if (!arrayProto.reduce) var inject = Enumerable.inject;
    Object.extend(arrayProto, Enumerable), arrayProto._reverse || (arrayProto._reverse = arrayProto.reverse), Object.extend(arrayProto, {
        _each: _each,
        map: map,
        collect: map,
        select: filter,
        filter: filter,
        findAll: filter,
        some: some,
        any: some,
        every: every,
        all: every,
        inject: inject,
        clear: clear,
        first: first,
        last: last,
        compact: compact,
        flatten: flatten,
        without: without,
        reverse: reverse,
        uniq: uniq,
        intersect: intersect,
        clone: clone,
        toArray: clone,
        size: size,
        inspect: inspect
    });
    var CONCAT_ARGUMENTS_BUGGY = function() {
        
return [].concat(arguments)[0][0] !== 1;
    }(1, 2);
    CONCAT_ARGUMENTS_BUGGY && (arrayProto.concat = concat), arrayProto.indexOf || (arrayProto.indexOf = indexOf), arrayProto.lastIndexOf || (arrayProto.lastIndexOf = lastIndexOf);
}();

function $H(object) {
    return new Hash(object);
}

var Hash = Class.create(Enumerable, function() {
    function initialize(object) {
        this._object = Object.isHash(object) ? object.toObject() : Object.clone(object);
    }
    function _each(iterator, context) {
        for (var key in this._object) {
            var value = this._object[key], pair = [ key, value ];
            pair.key = key, pair.value = value, iterator.call(context, pair);
        }
    }
    function set(key, value) {
        return this._object[key] = value;
    }
    function get(key) {
        if (this._object[key] !== Object.prototype[key]) return this._object[key];
    }
    function unset(key) {
        var value = this._object[key];
        return delete this._object
[key], value;
    }
    function toObject() {
        return Object.clone(this._object);
    }
    function keys() {
        return this.pluck("key");
    }
    function values() {
        return this.pluck("value");
    }
    function index(value) {
        var match = this.detect(function(pair) {
            return pair.value === value;
        });
        return match && match.key;
    }
    function merge(object) {
        return this.clone().update(object);
    }
    function update(object) {
        return (new Hash(object)).inject(this, function(result, pair) {
            return result.set(pair.key, pair.value), result;
        });
    }
    function toQueryPair(key, value) {
        if (Object.isUndefined(value)) return key;
        var value = String.interpret(value);
        return value = value.gsub(/(\r)?\n/, "\r\n"), value = encodeURIComponent(value), value = value.gsub(/%20/, "+"), key + "=" + value;
    }
    function toQueryString() {
        return this.inject([], function(
results, pair) {
            var key = encodeURIComponent(pair.key), values = pair.value;
            if (values && typeof values == "object") {
                if (Object.isArray(values)) {
                    var queryValues = [];
                    for (var i = 0, len = values.length, value; i < len; i++) value = values[i], queryValues.push(toQueryPair(key, value));
                    return results.concat(queryValues);
                }
            } else results.push(toQueryPair(key, values));
            return results;
        }).join("&");
    }
    function inspect() {
        return "#<Hash:{" + this.map(function(pair) {
            return pair.map(Object.inspect).join(": ");
        }).join(", ") + "}>";
    }
    function clone() {
        return new Hash(this);
    }
    return {
        initialize: initialize,
        _each: _each,
        set: set,
        get: get,
        unset: unset,
        toObject: toObject,
        toTemplateReplacements: toObject,
        keys: 
keys,
        values: values,
        index: index,
        merge: merge,
        update: update,
        toQueryString: toQueryString,
        inspect: inspect,
        toJSON: toObject,
        clone: clone
    };
}());

Hash.from = $H, Object.extend(Number.prototype, function() {
    function toColorPart() {
        return this.toPaddedString(2, 16);
    }
    function succ() {
        return this + 1;
    }
    function times(iterator, context) {
        return $R(0, this, !0).each(iterator, context), this;
    }
    function toPaddedString(length, radix) {
        var string = this.toString(radix || 10);
        return "0".times(length - string.length) + string;
    }
    function abs() {
        return Math.abs(this);
    }
    function round() {
        return Math.round(this);
    }
    function ceil() {
        return Math.ceil(this);
    }
    function floor() {
        return Math.floor(this);
    }
    return {
        toColorPart: toColorPart,
        succ: succ,
        times
: times,
        toPaddedString: toPaddedString,
        abs: abs,
        round: round,
        ceil: ceil,
        floor: floor
    };
}());

function $R(start, end, exclusive) {
    return new ObjectRange(start, end, exclusive);
}

var ObjectRange = Class.create(Enumerable, function() {
    function initialize(start, end, exclusive) {
        this.start = start, this.end = end, this.exclusive = exclusive;
    }
    function _each(iterator, context) {
        var value = this.start;
        while (this.include(value)) iterator.call(context, value), value = value.succ();
    }
    function include(value) {
        return value < this.start ? !1 : this.exclusive ? value < this.end : value <= this.end;
    }
    return {
        initialize: initialize,
        _each: _each,
        include: include
    };
}()), Abstract = {}, Try = {
    these: function() {
        var returnValue = null;
        for (var i = 0, length = arguments.length; i < length; i++) {
            var lambda = arguments
[i];
            try {
                returnValue = lambda();
                break;
            } catch (e) {}
        }
        return returnValue;
    }
};

define("prototype", function() {}), define("text", [ "module" ], function(module) {
    var text, fs, Cc, Ci, xpcIsWindows, progIds = [ "Msxml2.XMLHTTP", "Microsoft.XMLHTTP", "Msxml2.XMLHTTP.4.0" ], xmlRegExp = /^\s*<\?xml(\s)+version=[\'\"](\d)*.(\d)*[\'\"](\s)*\?>/im, bodyRegExp = /<body[^>]*>\s*([\s\S]+)\s*<\/body>/im, hasLocation = typeof location != "undefined" && location.href, defaultProtocol = hasLocation && location.protocol && location.protocol.replace(/\:/, ""), defaultHostName = hasLocation && location.hostname, defaultPort = hasLocation && (location.port || undefined), buildMap = {}, masterConfig = module.config && module.config() || {};
    text = {
        version: "2.0.12",
        strip: function(content) {
            if (content) {
                content = content.replace(xmlRegExp, "");
                var matches = 
content.match(bodyRegExp);
                matches && (content = matches[1]);
            } else content = "";
            return content;
        },
        jsEscape: function(content) {
            return content.replace(/(['\\])/g, "\\$1").replace(/[\f]/g, "\\f").replace(/[\b]/g, "\\b").replace(/[\n]/g, "\\n").replace(/[\t]/g, "\\t").replace(/[\r]/g, "\\r").replace(/[\u2028]/g, "\\u2028").replace(/[\u2029]/g, "\\u2029");
        },
        createXhr: masterConfig.createXhr || function() {
            var xhr, i, progId;
            if (typeof XMLHttpRequest != "undefined") return new XMLHttpRequest;
            if (typeof ActiveXObject != "undefined") for (i = 0; i < 3; i += 1) {
                progId = progIds[i];
                try {
                    xhr = new ActiveXObject(progId);
                } catch (e) {}
                if (xhr) {
                    progIds = [ progId ];
                    break;
                }
            }
            return xhr;
        },
        
parseName: function(name) {
            var modName, ext, temp, strip = !1, index = name.indexOf("."), isRelative = name.indexOf("./") === 0 || name.indexOf("../") === 0;
            return index !== -1 && (!isRelative || index > 1) ? (modName = name.substring(0, index), ext = name.substring(index + 1, name.length)) : modName = name, temp = ext || modName, index = temp.indexOf("!"), index !== -1 && (strip = temp.substring(index + 1) === "strip", temp = temp.substring(0, index), ext ? ext = temp : modName = temp), {
                moduleName: modName,
                ext: ext,
                strip: strip
            };
        },
        xdRegExp: /^((\w+)\:)?\/\/([^\/\\]+)/,
        useXhr: function(url, protocol, hostname, port) {
            var uProtocol, uHostName, uPort, match = text.xdRegExp.exec(url);
            return match ? (uProtocol = match[2], uHostName = match[3], uHostName = uHostName.split(":"), uPort = uHostName[1], uHostName = uHostName[0], (!uProtocol || uProtocol === 
protocol) && (!uHostName || uHostName.toLowerCase() === hostname.toLowerCase()) && (!uPort && !uHostName || uPort === port)) : !0;
        },
        finishLoad: function(name, strip, content, onLoad) {
            content = strip ? text.strip(content) : content, masterConfig.isBuild && (buildMap[name] = content), onLoad(content);
        },
        load: function(name, req, onLoad, config) {
            if (config && config.isBuild && !config.inlineText) {
                onLoad();
                return;
            }
            masterConfig.isBuild = config && config.isBuild;
            var parsed = text.parseName(name), nonStripName = parsed.moduleName + (parsed.ext ? "." + parsed.ext : ""), url = req.toUrl(nonStripName), useXhr = masterConfig.useXhr || text.useXhr;
            if (url.indexOf("empty:") === 0) {
                onLoad();
                return;
            }
            !hasLocation || useXhr(url, defaultProtocol, defaultHostName, defaultPort) ? text.get(url, function(
content) {
                text.finishLoad(name, parsed.strip, content, onLoad);
            }, function(err) {
                onLoad.error && onLoad.error(err);
            }) : req([ nonStripName ], function(content) {
                text.finishLoad(parsed.moduleName + "." + parsed.ext, parsed.strip, content, onLoad);
            });
        },
        write: function(pluginName, moduleName, write, config) {
            if (buildMap.hasOwnProperty(moduleName)) {
                var content = text.jsEscape(buildMap[moduleName]);
                write.asModule(pluginName + "!" + moduleName, "define(function () { return '" + content + "';});\n");
            }
        },
        writeFile: function(pluginName, moduleName, req, write, config) {
            var parsed = text.parseName(moduleName), extPart = parsed.ext ? "." + parsed.ext : "", nonStripName = parsed.moduleName + extPart, fileName = req.toUrl(parsed.moduleName + extPart) + ".js";
            text.load(nonStripName, req, function(
value) {
                var textWrite = function(contents) {
                    return write(fileName, contents);
                };
                textWrite.asModule = function(moduleName, contents) {
                    return write.asModule(moduleName, fileName, contents);
                }, text.write(pluginName, nonStripName, textWrite, config);
            }, config);
        }
    };
    if (masterConfig.env === "node" || !masterConfig.env && typeof process != "undefined" && process.versions && !!process.versions.node && !process.versions["node-webkit"]) fs = require.nodeRequire("fs"), text.get = function(url, callback, errback) {
        try {
            var file = fs.readFileSync(url, "utf8");
            file.indexOf("\ufeff") === 0 && (file = file.substring(1)), callback(file);
        } catch (e) {
            errback && errback(e);
        }
    }; else if (masterConfig.env === "xhr" || !masterConfig.env && text.createXhr()) text.get = function(url, callback, errback, headers
) {
        var xhr = text.createXhr(), header;
        xhr.open("GET", url, !0);
        if (headers) for (header in headers) headers.hasOwnProperty(header) && xhr.setRequestHeader(header.toLowerCase(), headers[header]);
        masterConfig.onXhr && masterConfig.onXhr(xhr, url), xhr.onreadystatechange = function(evt) {
            var status, err;
            xhr.readyState === 4 && (status = xhr.status || 0, status > 399 && status < 600 ? (err = new Error(url + " HTTP status: " + status), err.xhr = xhr, errback && errback(err)) : callback(xhr.responseText), masterConfig.onXhrComplete && masterConfig.onXhrComplete(xhr, url));
        }, xhr.send(null);
    }; else if (masterConfig.env === "rhino" || !masterConfig.env && typeof Packages != "undefined" && typeof java != "undefined") text.get = function(url, callback) {
        var stringBuffer, line, encoding = "utf-8", file = new java.io.File(url), lineSeparator = java.lang.System.getProperty("line.separator"), input = new java.io.BufferedReader
(new java.io.InputStreamReader(new java.io.FileInputStream(file), encoding)), content = "";
        try {
            stringBuffer = new java.lang.StringBuffer, line = input.readLine(), line && line.length() && line.charAt(0) === 65279 && (line = line.substring(1)), line !== null && stringBuffer.append(line);
            while ((line = input.readLine()) !== null) stringBuffer.append(lineSeparator), stringBuffer.append(line);
            content = String(stringBuffer.toString());
        } finally {
            input.close();
        }
        callback(content);
    }; else if (masterConfig.env === "xpconnect" || !masterConfig.env && typeof Components != "undefined" && Components.classes && Components.interfaces) Cc = Components.classes, Ci = Components.interfaces, Components.utils["import"]("resource://gre/modules/FileUtils.jsm"), xpcIsWindows = "@mozilla.org/windows-registry-key;1" in Cc, text.get = function(url, callback) {
        var inStream, convertStream, fileObj, readData = {};
        
xpcIsWindows && (url = url.replace(/\//g, "\\")), fileObj = new FileUtils.File(url);
        try {
            inStream = Cc["@mozilla.org/network/file-input-stream;1"].createInstance(Ci.nsIFileInputStream), inStream.init(fileObj, 1, 0, !1), convertStream = Cc["@mozilla.org/intl/converter-input-stream;1"].createInstance(Ci.nsIConverterInputStream), convertStream.init(inStream, "utf-8", inStream.available(), Ci.nsIConverterInputStream.DEFAULT_REPLACEMENT_CHARACTER), convertStream.readString(inStream.available(), readData), convertStream.close(), inStream.close(), callback(readData.value);
        } catch (e) {
            throw new Error((fileObj && fileObj.path || "") + ": " + e);
        }
    };
    return text;
}), define("text!partials/mainApp.html", [], function() {
    return '<div class="container-fluid my-container-fluid-heihgt">\r\n    <div class="row portal-height">\r\n        <div class="col-xs-4 col-sm-8 col-md-7 col-lg-8">\r\n        </div>\r\n        <div class="col-xs-4 col-sm-2 col-md-3 col-lg-2 text-center">\r\n            <span id="config-director" class="my-font-style" data-lang="{text:config_guide+:}"></span>\r\n        </div>\r\n        <div class="col-xs-4 col-sm-2 col-md-2 col-lg-2">\r\n            <div class="my-float">\r\n                <a href="../../index.jsp" id="sennior-config" class="my-font-style" data-lang="{text:sennior_config+:}"></a>\r\n            </div>\r\n        </div>\r\n    </div>\r\n    <div class="row my-margin-top">\r\n        <div class="col-xs-12 col-sm-4 col-sm-offset-3 col-md-4 col-md-offset-4 col-lg-3 col-lg-offset-5">\r\n            <div class="row infomation-div-network-color infomation-div my-row-1 my-border-radius">\r\n                <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">\r\n                    <h5 class="my-font-weight" data-lang="{text:network}"></h5>\r\n                    <div class="row" style="margin-top: 35px">\r\n                        <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">\r\n                        </div>\r\n                        <div class="col-xs-8 col-sm-8 col-md-8 col-lg-8">\r\n                            <label class="my-own-font-size my-s-margin-top" data-lang="{text:status}"></label>:\r\n                            <span id="network-state"></span>\r\n                        </div>\r\n                    </div>\r\n                    <div class="row">\r\n                        <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4"></div>\r\n                        <div class="col-xs-8 col-sm-8 col-md-8 col-lg-8">\r\n                            <label class="my-own-font-size my-s-margin-top" data-lang="{text:duration}"></label>:\r\n                            <span id="network-period"></span>\r\n                        </div>\r\n                    </div>\r\n                    <!--<div class="row">-->\r\n                        <!--<div class="col-xs-4 col-sm-4 col-md-4 col-lg-4"></div>-->\r\n                        <!--<div class="col-xs-8 col-sm-8 col-md-8 col-lg-8">-->\r\n                            <!--<label class="my-own-font-size my-s-margin-top" data-lang="{text:flow}"></label>:-->\r\n                            <!--<span id="network-flow"></span>-->\r\n                        <!--</div>-->\r\n                    <!--</div>-->\r\n                </div>\r\n            </div>\r\n        </div>\r\n        <!--<div class="col-xs-12 col-sm-4 col-md-4 col-lg-3 col-lg-offset-1">-->\r\n            <!--<div class="row infomation-div-wifi-color infomation-div my-row-2 my-border-radius">-->\r\n                <!--<div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">-->\r\n                    <!--<h5 class="my-font-weight" data-lang="{text:wireless}"></h5>-->\r\n                    <!--<div class="row">-->\r\n                        <!--<div class="col-xs-4 col-sm-4 col-md-4 col-lg-4"></div>-->\r\n                        <!--<div class="col-xs-8 col-sm-8 col-md-8 col-lg-8">-->\r\n                            <!--<label class="my-own-font-size my-s-margin-top" data-lang="{text:wifi_spot}"></label>:-->\r\n                            <!--<span id="wifi-ssid"></span>-->\r\n                        <!--</div>-->\r\n                    <!--</div>-->\r\n                    <!--<div class="row">-->\r\n                        <!--<div class="col-xs-4 col-sm-4 col-md-4 col-lg-4"></div>-->\r\n                        <!--<div class="col-xs-8 col-sm-8 col-md-8 col-lg-8">-->\r\n                            <!--<label class="my-own-font-size my-s-margin-top" data-lang="{text:connections}"></label>:-->\r\n                            <!--<span id="wifi-devices"></span>-->\r\n                        <!--</div>-->\r\n                    <!--</div>-->\r\n                    <!--<div class="row">-->\r\n                        <!--<div class="col-xs-4 col-sm-4 col-md-4 col-lg-4"></div>-->\r\n                        <!--<div class="col-xs-8 col-sm-8 col-md-8 col-lg-8">-->\r\n                            <!--<label class="my-own-font-size my-s-margin-top" data-lang="{text:users}"></label>:-->\r\n                            <!--<span id="wifi-users"></span>-->\r\n                        <!--</div>-->\r\n                    <!--</div>-->\r\n                <!--</div>-->\r\n            <!--</div>-->\r\n        <!--</div>-->\r\n        <!--<div class="col-xs-12 col-sm-4 col-md-4 col-lg-3 col-lg-offset-1">-->\r\n            <!--<div class="row infomation-div-sync-color infomation-div my-row-3 my-border-radius">-->\r\n                <!--<div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">-->\r\n                    <!--<h5 class="my-font-weight" data-lang="{text:content_synchro}"></h5>-->\r\n                    <!--<div class="row">-->\r\n                        <!--<div class="col-xs-4 col-sm-4 col-md-4 col-lg-4"></div>-->\r\n                        <!--<div class="col-xs-8 col-sm-8 col-md-8 col-lg-8">-->\r\n                            <!--<label class="my-own-font-size my-s-margin-top" data-lang="{text:html}"></label>:-->\r\n                            <!--<span id="sync-html"></span>-->\r\n                        <!--</div>-->\r\n                    <!--</div>-->\r\n                    <!--<div class="row">-->\r\n                        <!--<div class="col-xs-4 col-sm-4 col-md-4 col-lg-4"></div>-->\r\n                        <!--<div class="col-xs-8 col-sm-8 col-md-8 col-lg-8">-->\r\n                            <!--<label class="my-own-font-size my-s-margin-top" data-lang="{text:scripts}"></label>:-->\r\n                            <!--<span id="sync-scripts"></span>-->\r\n                        <!--</div>-->\r\n                    <!--</div>-->\r\n                    <!--<div class="row">-->\r\n                        <!--<div class="col-xs-4 col-sm-4 col-md-4 col-lg-4"></div>-->\r\n                        <!--<div class="col-xs-8 col-sm-8 col-md-8 col-lg-8">-->\r\n                            <!--<label id="" class="my-own-font-size my-s-margin-top" data-lang="{text:conf}"></label>:-->\r\n                            <!--<span id="sync-conf"></span>-->\r\n                        <!--</div>-->\r\n                    <!--</div>-->\r\n                <!--</div>-->\r\n            <!--</div>-->\r\n        <!--</div>-->\r\n    </div>\r\n</div>'
;
}), function() {
    function setup($) {
        $.fn._fadeIn = $.fn.fadeIn;
        var noOp = $.noop || function() {}, msie = /MSIE/.test(navigator.userAgent), ie6 = /MSIE 6.0/.test(navigator.userAgent) && !/MSIE 8.0/.test(navigator.userAgent), mode = document.documentMode || 0, setExpr = $.isFunction(document.createElement("div").style.setExpression);
        $.blockUI = function(opts) {
            install(window, opts);
        }, $.unblockUI = function(opts) {
            remove(window, opts);
        }, $.growlUI = function(title, message, timeout, onClose) {
            var $m = $('<div class="growlUI"></div>');
            title && $m.append("<h1>" + title + "</h1>"), message && $m.append("<h2>" + message + "</h2>"), timeout === undefined && (timeout = 3e3);
            var callBlock = function(opts) {
                opts = opts || {}, $.blockUI({
                    message: $m,
                    fadeIn: typeof opts.fadeIn != "undefined" ? opts.fadeIn : 700,
                    
fadeOut: typeof opts.fadeOut != "undefined" ? opts.fadeOut : 1e3,
                    timeout: typeof opts.timeout != "undefined" ? opts.timeout : timeout,
                    centerY: !1,
                    showOverlay: !1,
                    onUnblock: onClose,
                    css: $.blockUI.defaults.growlCSS
                });
            };
            callBlock();
            var nonmousedOpacity = $m.css("opacity");
            $m.mouseover(function() {
                callBlock({
                    fadeIn: 0,
                    timeout: 3e4
                });
                var displayBlock = $(".blockMsg");
                displayBlock.stop(), displayBlock.fadeTo(300, 1);
            }).mouseout(function() {
                $(".blockMsg").fadeOut(1e3);
            });
        }, $.fn.block = function(opts) {
            if (this[0] === window) return $.blockUI(opts), this;
            var fullOpts = $.extend({}, $.blockUI.defaults, opts || {});
            return this
.each(function() {
                var $el = $(this);
                if (fullOpts.ignoreIfBlocked && $el.data("blockUI.isBlocked")) return;
                $el.unblock({
                    fadeOut: 0
                });
            }), this.each(function() {
                $.css(this, "position") == "static" && (this.style.position = "relative", $(this).data("blockUI.static", !0)), this.style.zoom = 1, install(this, opts);
            });
        }, $.fn.unblock = function(opts) {
            return this[0] === window ? ($.unblockUI(opts), this) : this.each(function() {
                remove(this, opts);
            });
        }, $.blockUI.version = 2.66, $.blockUI.defaults = {
            message: "<h1>Please wait...</h1>",
            title: null,
            draggable: !0,
            theme: !1,
            css: {
                padding: 0,
                margin: 0,
                width: "30%",
                top: "40%",
                left: "35%",
                textAlign
: "center",
                color: "#000",
                border: "3px solid #aaa",
                backgroundColor: "#fff",
                cursor: "wait"
            },
            themedCSS: {
                width: "30%",
                top: "40%",
                left: "35%"
            },
            overlayCSS: {
                backgroundColor: "#000",
                opacity: .6,
                cursor: "wait"
            },
            cursorReset: "default",
            growlCSS: {
                width: "350px",
                top: "10px",
                left: "",
                right: "10px",
                border: "none",
                padding: "5px",
                opacity: .6,
                cursor: "default",
                color: "#fff",
                backgroundColor: "#000",
                "-webkit-border-radius": "10px",
                "-moz-border-radius": "10px",
                "border-radius": "10px"
            },
            iframeSrc: /^https/i.
test(window.location.href || "") ? "javascript:false" : "about:blank",
            forceIframe: !1,
            baseZ: 1e3,
            centerX: !0,
            centerY: !0,
            allowBodyStretch: !0,
            bindEvents: !0,
            constrainTabKey: !0,
            fadeIn: 200,
            fadeOut: 400,
            timeout: 0,
            showOverlay: !0,
            focusInput: !0,
            focusableElements: ":input:enabled:visible",
            onBlock: null,
            onUnblock: null,
            onOverlayClick: null,
            quirksmodeOffsetHack: 4,
            blockMsgClass: "blockMsg",
            ignoreIfBlocked: !1
        };
        var pageBlock = null, pageBlockEls = [];
        function install(el, opts) {
            var css, themedCSS, full = el == window, msg = opts && opts.message !== undefined ? opts.message : undefined;
            opts = $.extend({}, $.blockUI.defaults, opts || {});
            if (opts.ignoreIfBlocked && $(el).data("blockUI.isBlocked"
)) return;
            opts.overlayCSS = $.extend({}, $.blockUI.defaults.overlayCSS, opts.overlayCSS || {}), css = $.extend({}, $.blockUI.defaults.css, opts.css || {}), opts.onOverlayClick && (opts.overlayCSS.cursor = "pointer"), themedCSS = $.extend({}, $.blockUI.defaults.themedCSS, opts.themedCSS || {}), msg = msg === undefined ? opts.message : msg, full && pageBlock && remove(window, {
                fadeOut: 0
            });
            if (msg && typeof msg != "string" && (msg.parentNode || msg.jquery)) {
                var node = msg.jquery ? msg[0] : msg, data = {};
                $(el).data("blockUI.history", data), data.el = node, data.parent = node.parentNode, data.display = node.style.display, data.position = node.style.position, data.parent && data.parent.removeChild(node);
            }
            $(el).data("blockUI.onUnblock", opts.onUnblock);
            var z = opts.baseZ, lyr1, lyr2, lyr3, s;
            msie || opts.forceIframe ? lyr1 = $('<iframe class="blockUI" style="z-index:' + 
z++ + ';display:none;border:none;margin:0;padding:0;position:absolute;width:100%;height:100%;top:0;left:0" src="' + opts.iframeSrc + '"></iframe>') : lyr1 = $('<div class="blockUI" style="display:none"></div>'), opts.theme ? lyr2 = $('<div class="blockUI blockOverlay ui-widget-overlay" style="z-index:' + z++ + ';display:none"></div>') : lyr2 = $('<div class="blockUI blockOverlay" style="z-index:' + z++ + ';display:none;border:none;margin:0;padding:0;width:100%;height:100%;top:0;left:0"></div>'), opts.theme && full ? (s = '<div class="blockUI ' + opts.blockMsgClass + ' blockPage ui-dialog ui-widget ui-corner-all" style="z-index:' + (z + 10) + ';display:none;position:fixed">', opts.title && (s += '<div class="ui-widget-header ui-dialog-titlebar ui-corner-all blockTitle">' + (opts.title || "&nbsp;") + "</div>"), s += '<div class="ui-widget-content ui-dialog-content"></div>', s += "</div>") : opts.theme ? (s = '<div class="blockUI ' + opts.blockMsgClass + ' blockElement ui-dialog ui-widget ui-corner-all" style="z-index:' + 
(z + 10) + ';display:none;position:absolute">', opts.title && (s += '<div class="ui-widget-header ui-dialog-titlebar ui-corner-all blockTitle">' + (opts.title || "&nbsp;") + "</div>"), s += '<div class="ui-widget-content ui-dialog-content"></div>', s += "</div>") : full ? s = '<div class="blockUI ' + opts.blockMsgClass + ' blockPage" style="z-index:' + (z + 10) + ';display:none;position:fixed"></div>' : s = '<div class="blockUI ' + opts.blockMsgClass + ' blockElement" style="z-index:' + (z + 10) + ';display:none;position:absolute"></div>', lyr3 = $(s), msg && (opts.theme ? (lyr3.css(themedCSS), lyr3.addClass("ui-widget-content")) : lyr3.css(css)), opts.theme || lyr2.css(opts.overlayCSS), lyr2.css("position", full ? "fixed" : "absolute"), (msie || opts.forceIframe) && lyr1.css("opacity", 0);
            var layers = [ lyr1, lyr2, lyr3 ], $par = full ? $("body") : $(el);
            $.each(layers, function() {
                this.appendTo($par);
            }), opts.theme && opts.draggable && 
$.fn.draggable && lyr3.draggable({
                handle: ".ui-dialog-titlebar",
                cancel: "li"
            });
            var expr = setExpr && (!$.support.boxModel || $("object,embed", full ? null : el).length > 0);
            if (ie6 || expr) {
                full && opts.allowBodyStretch && $.support.boxModel && $("html,body").css("height", "100%");
                if ((ie6 || !$.support.boxModel) && !full) var t = sz(el, "borderTopWidth"), l = sz(el, "borderLeftWidth"), fixT = t ? "(0 - " + t + ")" : 0, fixL = l ? "(0 - " + l + ")" : 0;
                $.each(layers, function(i, o) {
                    var s = o[0].style;
                    s.position = "absolute";
                    if (i < 2) full ? s.setExpression("height", "Math.max(document.body.scrollHeight, document.body.offsetHeight) - (jQuery.support.boxModel?0:" + opts.quirksmodeOffsetHack + ') + "px"') : s.setExpression("height", 'this.parentNode.offsetHeight + "px"'), full ? s.setExpression("width", 'jQuery.support.boxModel && document.documentElement.clientWidth || document.body.clientWidth + "px"'
) : s.setExpression("width", 'this.parentNode.offsetWidth + "px"'), fixL && s.setExpression("left", fixL), fixT && s.setExpression("top", fixT); else if (opts.centerY) full && s.setExpression("top", '(document.documentElement.clientHeight || document.body.clientHeight) / 2 - (this.offsetHeight / 2) + (blah = document.documentElement.scrollTop ? document.documentElement.scrollTop : document.body.scrollTop) + "px"'), s.marginTop = 0; else if (!opts.centerY && full) {
                        var top = opts.css && opts.css.top ? parseInt(opts.css.top, 10) : 0, expression = "((document.documentElement.scrollTop ? document.documentElement.scrollTop : document.body.scrollTop) + " + top + ') + "px"';
                        s.setExpression("top", expression);
                    }
                });
            }
            msg && (opts.theme ? lyr3.find(".ui-widget-content").append(msg) : lyr3.append(msg), (msg.jquery || msg.nodeType) && $(msg).show()), (msie || opts.forceIframe) && opts.showOverlay && 
lyr1.show();
            if (opts.fadeIn) {
                var cb = opts.onBlock ? opts.onBlock : noOp, cb1 = opts.showOverlay && !msg ? cb : noOp, cb2 = msg ? cb : noOp;
                opts.showOverlay && lyr2._fadeIn(opts.fadeIn, cb1), msg && lyr3._fadeIn(opts.fadeIn, cb2);
            } else opts.showOverlay && lyr2.show(), msg && lyr3.show(), opts.onBlock && opts.onBlock();
            bind(1, el, opts), full ? (pageBlock = lyr3[0], pageBlockEls = $(opts.focusableElements, pageBlock), opts.focusInput && setTimeout(focus, 20)) : center(lyr3[0], opts.centerX, opts.centerY);
            if (opts.timeout) {
                var to = setTimeout(function() {
                    full ? $.unblockUI(opts) : $(el).unblock(opts);
                }, opts.timeout);
                $(el).data("blockUI.timeout", to);
            }
        }
        function remove(el, opts) {
            var count, full = el == window, $el = $(el), data = $el.data("blockUI.history"), to = $el.data("blockUI.timeout"
);
            to && (clearTimeout(to), $el.removeData("blockUI.timeout")), opts = $.extend({}, $.blockUI.defaults, opts || {}), bind(0, el, opts), opts.onUnblock === null && (opts.onUnblock = $el.data("blockUI.onUnblock"), $el.removeData("blockUI.onUnblock"));
            var els;
            full ? els = $("body").children().filter(".blockUI").add("body > .blockUI") : els = $el.find(">.blockUI"), opts.cursorReset && (els.length > 1 && (els[1].style.cursor = opts.cursorReset), els.length > 2 && (els[2].style.cursor = opts.cursorReset)), full && (pageBlock = pageBlockEls = null), opts.fadeOut ? (count = els.length, els.stop().fadeOut(opts.fadeOut, function() {
                --count === 0 && reset(els, data, opts, el);
            })) : reset(els, data, opts, el);
        }
        function reset(els, data, opts, el) {
            var $el = $(el);
            if ($el.data("blockUI.isBlocked")) return;
            els.each(function(i, o) {
                this.parentNode && this.parentNode
.removeChild(this);
            }), data && data.el && (data.el.style.display = data.display, data.el.style.position = data.position, data.parent && data.parent.appendChild(data.el), $el.removeData("blockUI.history")), $el.data("blockUI.static") && $el.css("position", "static"), typeof opts.onUnblock == "function" && opts.onUnblock(el, opts);
            var body = $(document.body), w = body.width(), cssW = body[0].style.width;
            body.width(w - 1).width(w), body[0].style.width = cssW;
        }
        function bind(b, el, opts) {
            var full = el == window, $el = $(el);
            if (!b && (full && !pageBlock || !full && !$el.data("blockUI.isBlocked"))) return;
            $el.data("blockUI.isBlocked", b);
            if (!full || !opts.bindEvents || b && !opts.showOverlay) return;
            var events = "mousedown mouseup keydown keypress keyup touchstart touchend touchmove";
            b ? $(document).bind(events, opts, handler) : $(document).unbind(events, handler
);
        }
        function handler(e) {
            if (e.type === "keydown" && e.keyCode && e.keyCode == 9 && pageBlock && e.data.constrainTabKey) {
                var els = pageBlockEls, fwd = !e.shiftKey && e.target === els[els.length - 1], back = e.shiftKey && e.target === els[0];
                if (fwd || back) return setTimeout(function() {
                    focus(back);
                }, 10), !1;
            }
            var opts = e.data, target = $(e.target);
            return target.hasClass("blockOverlay") && opts.onOverlayClick && opts.onOverlayClick(e), target.parents("div." + opts.blockMsgClass).length > 0 ? !0 : target.parents().children().filter("div.blockUI").length === 0;
        }
        function focus(back) {
            if (!pageBlockEls) return;
            var e = pageBlockEls[back === !0 ? pageBlockEls.length - 1 : 0];
            e && e.focus();
        }
        function center(el, x, y) {
            var p = el.parentNode, s = el.style, l = (p.offsetWidth - 
el.offsetWidth) / 2 - sz(p, "borderLeftWidth"), t = (p.offsetHeight - el.offsetHeight) / 2 - sz(p, "borderTopWidth");
            x && (s.left = l > 0 ? l + "px" : "0"), y && (s.top = t > 0 ? t + "px" : "0");
        }
        function sz(el, p) {
            return parseInt($.css(el, p), 10) || 0;
        }
    }
    typeof define == "function" && define.amd && define.amd.jQuery ? define("lib/jquery.blockUI", [ "jquery" ], setup) : setup(jQuery);
}(), define("lang/en/lang", {
    inportal_description: "InPortal Smart WI-FI router",
    copyright: "Copyright \u00a9 Beijing Inhand Network Technology Co., Ltd.",
    welcome: "Welcome",
    exit: "Exit",
    config_guide: "Wizard",
    sennior_config: "Advanced",
    network: "Network",
    status: "State",
    duration: "Duration",
    flow: "Flow",
    wireless: "Wireless",
    wifi_spot: "Wifi spot",
    connections: "Connections",
    users: "Users",
    content_synchro: "Content Synchro",
    html: "html",
    scripts: "scripts",
    
conf: "conf",
    return_to_home: "Home",
    interface_type: "Interface Type",
    apn: "APN",
    username: "Username",
    password: "Password",
    dial_numbers: "Dialed Numbers",
    main_ip: "IP Address",
    subnet_mask: "Subnet Mask",
    gateway: "Gateway",
    preferred_domain: "Preferred DNS",
    alternate_domain: "Alternate DNS",
    pre_step: "Previous",
    next_step: "Next",
    demo_mode: "Demo Mode",
    port: "Port",
    enter_ip_address: "Enter Ip or host",
    rainbow_ip: "Rainbow Address",
    apply_config: "Complete",
    host_name: "Host",
    mac_address: "Mac",
    select_all: "Select All",
    white_mac_1: "White Mac 1",
    white_mac_2: "White Mac 2",
    white_mac_3: "White Mac 3",
    white_mac_4: "White Mac 4",
    white_mac_5: "White Mac 5",
    enter_mac: "Enter Mac",
    please_wait: "Please Wait...",
    connect_internet: "Connect InterNet",
    manage_platform: "Manage Platform",
    minutes: "minute(s)",
    seconds: "second(s)",
    hours: "hour(s)"
,
    days: "day(s)",
    connected: "connected",
    disconnected: "disconnected"
}), define("lang/zh_CN/lang", {
    inportal_description: "InPortal\u667a\u80fdWI-FI\u8def\u7531\u5668",
    copyright: "\u7248\u6743\u6240\u6709&copy;\u5317\u4eac\u6620\u7ff0\u901a\u7f51\u7edc\u6280\u672f\u80a1\u4efd\u6709\u9650\u516c\u53f8",
    welcome: "\u6b22\u8fce",
    exit: "\u9000\u51fa",
    config_guide: "\u914d\u7f6e\u5411\u5bfc",
    sennior_config: "\u9ad8\u7ea7\u914d\u7f6e",
    network: "\u7f51\u7edc\u94fe\u63a5",
    status: "\u72b6\u6001",
    duration: "\u8fde\u63a5\u65f6\u957f",
    flow: "\u6d41\u91cf",
    wireless: "\u65e0\u7ebf\u7f51\u7edc",
    wifi_spot: "Wifi\u70ed\u70b9",
    connections: "\u8fde\u63a5\u6570",
    users: "\u7528\u6237\u6570",
    content_synchro: "\u5185\u5bb9\u540c\u6b65\u72b6\u6001",
    html: "html",
    scripts: "scripts",
    conf: "conf",
    return_to_home: "\u8fd4\u56de\u9996\u9875",
    interface_type: "\u63a5\u53e3\u7c7b\u578b",
    apn: "APN",
    username
: "\u7528\u6237\u540d",
    password: "\u5bc6\u7801",
    dial_numbers: "\u62e8\u53f7\u53f7\u7801",
    main_ip: "IP\u5730\u5740",
    subnet_mask: "\u5b50\u7f51\u63a9\u7801",
    gateway: "\u7f51\u5173",
    preferred_domain: "\u9996\u9009\u57df\u540d\u670d\u52a1\u5668",
    alternate_domain: "\u5907\u9009\u57df\u540d\u670d\u52a1\u5668",
    pre_step: "\u4e0a\u4e00\u6b65",
    next_step: "\u4e0b\u4e00\u6b65",
    demo_mode: "\u6f14\u793a\u6a21\u5f0f",
    port: "\u7aef\u53e3",
    enter_ip_address: "\u8f93\u5165ip\u6216\u57df\u540d",
    rainbow_ip: "\u706b\u8679\u4e91\u5730\u5740",
    apply_config: "\u5b8c\u6210\u914d\u7f6e",
    host_name: "\u4e3b\u673a\u540d",
    mac_address: "Mac\u5730\u5740",
    select_all: "\u5168\u9009",
    white_mac_1: "\u767d\u540d\u5355Mac1",
    white_mac_2: "\u767d\u540d\u5355Mac2",
    white_mac_3: "\u767d\u540d\u5355Mac3",
    white_mac_4: "\u767d\u540d\u5355Mac4",
    white_mac_5: "\u767d\u540d\u5355Mac5",
    enter_mac: "\u8f93\u5165Mac\u5730\u5740"
,
    please_wait: "\u6b63\u5728\u5904\u7406...",
    connect_internet: "\u8fde\u63a5\u4e92\u8054\u7f51",
    manage_platform: "\u7ba1\u7406\u5e73\u53f0",
    minutes: "\u5206",
    seconds: "\u79d2",
    hours: "\u5c0f\u65f6",
    days: "\u5929",
    connected: "\u5df2\u8fde\u63a5",
    disconnected: "\u672a\u8fde\u63a5"
}), define("tool/locale", [ "require", "lang/en/lang", "lang/zh_CN/lang" ], function(require) {
    var enPackage = require("lang/en/lang"), zhPackage = require("lang/zh_CN/lang"), locale = {
        defaultLanguage: "zh_CN",
        english: enPackage,
        chinese: zhPackage,
        render: function() {
            var self = this, langDom = $("[data-lang]");
            self._setInner(langDom);
        },
        set: function(obj) {
            var self = this;
            obj.lang && (self.defaultLanguage = obj.lang), self.render();
        },
        get: function(keyStr) {
            var self = this;
            if (self.defaultLanguage == "zh_CN") return self
.chinese[keyStr];
            if (self.defaultLanguage == "en") return self.english[keyStr];
        },
        setLocalStorage: function(langstr) {
            var self = this;
            return localStorage.setItem("language", langstr), this;
        },
        _setInner: function(langDom) {
            var self = this, languagePack;
            self.defaultLanguage = localStorage.getItem("language"), self.defaultLanguage == "zh_CN" ? languagePack = self.chinese : self.defaultLanguage == "en" && (languagePack = self.english), langDom.each(function(one) {
                var domCur = $(langDom[one]), currentIndex = domCur.attr("data-lang"), lastLg = currentIndex.lastIndexOf("}"), tempStr = currentIndex.slice(1, lastLg), tempArr_1 = tempStr.split(",");
                tempArr_1.each(function(two) {
                    var smTempArr = two.split(":"), index = smTempArr[0];
                    if (smTempArr[1].indexOf("+") != -1) var xsTempArr = smTempArr[1].split("+");
                    
switch (index) {
                      case "text":
                        var str = "";
                        xsTempArr ? xsTempArr.each(function(one) {
                            languagePack[one] ? str += languagePack[one] : str += one;
                        }) : str = languagePack[smTempArr[1]], domCur.html(str);
                        break;
                      case "placeholder":
                        var str = "";
                        xsTempArr ? xsTempArr.each(function(one) {
                            languagePack[one] ? str += languagePack[one] : str += one;
                        }) : str = languagePack[smTempArr[1]], domCur.attr({
                            placeholder: str
                        });
                    }
                });
            });
        }
    };
    return locale;
}), define("app/originalApp", [ "require", "lib/jquery.blockUI", "tool/locale" ], function(require) {
    require("lib/jquery.blockUI");
    var locale = require("tool/locale"
), App = Class.create({
        initialize: function(options) {
            this.elementId = options.elementId, this.options = options, this.events = options.events, this.viewContainer = $("#" + options.elementId);
        },
        ajax: function(obj) {
            var self = this;
            obj.showBlock && $.blockUI({
                css: {
                    border: "none",
                    padding: "15px",
                    backgroundColor: "#1A1A1A",
                    "-webkit-border-radius": "10px",
                    "-moz-border-radius": "10px",
                    color: "#fff",
                    width: "20%",
                    left: "40%"
                },
                message: "<div><div class='mask_block table-cell'></div><div class='table-cell'>" + locale.get("please_wait") + "</div></div>"
            });
            var success = obj.success, success_f = function(data, textStatus) {
                success(data, textStatus), setTimeout(function() {
                    
$.unblockUI();
                }, 1500);
            }, error = obj.error, error_f = function(xhr, err) {
                setTimeout(function() {
                    $.unblockUI(), error(xhr, err);
                }, 1500);
            };
            $.ajax({
                url: obj.url,
                type: obj.type,
                contentType: obj.contentType,
                data: obj.data,
                processData: obj.processData,
                success: success_f,
                error: error_f
            });
        },
        fire: function(eventStr) {
            var self = this;
            self.events[eventStr].call(self.events.scope || self);
        },
        destroy: function() {
            var self = this;
            self.viewContainer.empty();
        }
    });
    return App;
}), define("text!app/../../css/mainApp.css", [], function() {
    return '\r\n.my-margin-left-checkbox{\r\n    margin-left:0px !important\r\n}\r\n.portal-height{\r\n    height:69px;\r\n    line-height: 69px;\r\n}\r\n.portal-line-height{\r\n    line-height: 69px;\r\n}\r\n.my-font-color-white{\r\n    color:rgb(255,255,255)\r\n}\r\n.my-font-color-blue{\r\n    color:#0769AD\r\n}\r\na:hover,a:focus{\r\n    color:rgb(255,255,255);\r\n    text-decoration:underline;\r\n    cursor:pointer\r\n}\r\na{\r\n    color:rgb(255,255,255)\r\n}\r\n.infomation-div{\r\n    height: 200px;\r\n    /*width: 320px;*/\r\n}\r\n.infomation-div-network-color{\r\n    background-color: rgb(206,67,31);\r\n    background-image: url("../images/1.png");\r\n    background-repeat: no-repeat;\r\n    background-position-x:10px ;\r\n    background-position-y:55px;\r\n}\r\n.infomation-div-wifi-color{\r\n    background-color: rgb(46,156,28);\r\n    background-image: url("../images/2.png");\r\n    background-repeat: no-repeat;\r\n    background-position-x:10px ;\r\n    background-position-y:35px;\r\n}\r\n.infomation-div-sync-color{\r\n    background-color: rgb(222,157,46);\r\n    background-image: url("../images/3.png");\r\n    background-repeat: no-repeat;\r\n    background-position-x:10px ;\r\n    background-position-y:35px;\r\n}\r\n.my-bg-color{\r\n    /*background-color:#136DC9;*/\r\n    height: 775px;\r\n    background: url("../images/bg.jpg");\r\n    background-size: cover;\r\n    /*margin-bottom: 167px;*/\r\n}\r\n.my-own-font-size{\r\n    font-size:12px\r\n}\r\n.a-underline{\r\n    text-decoration: underline;\r\n}\r\n.my-float{\r\n    float: right;\r\n}\r\n.my-margin-top{\r\n    margin-top:85px\r\n}\r\n.my-font-weight{\r\n    font-weight:700\r\n}\r\n.my-normal-font-weight{\r\n    font-weight:normal;\r\n}\r\n.my-s-margin-top{\r\n    margin-top:15px\r\n}\r\n.my-lable-line-height{\r\n    line-height: 34px;\r\n}\r\n.my-pre-step-next-step-height{\r\n    height:400px;\r\n    position: relative;\r\n}\r\n.down-z-index{\r\n    z-index: -1;\r\n}\r\n.my-table-container-scroll{\r\n    height:225px;\r\n    overflow-y:scroll;\r\n}\r\n.my-table-margin-top{\r\n    margin-top: 12px !important;\r\n}\r\n.my-container-fluid-heihgt{\r\n    height:469px\r\n}\r\n.my-border-radius{\r\n    border-radius: 5px\r\n}\r\n.my-title-img{\r\n    width: 110px;\r\n    height: 80px;\r\n    position: relative;\r\n    top: -19px;\r\n    /*background: url("../images/Logo-InHand.png");*/\r\n    /*background-size: cover;*/\r\n}\r\n.mask_block{\r\n    background-image: url("../images/wait.gif");\r\n    width: 90px;\r\n    height: 90px;\r\n    background-size: cover;\r\n}\r\n.table-cell{\r\n    display: table-cell;\r\n    vertical-align: middle;\r\n}\r\n.my-font-style{\r\n    font-size:16px;\r\n    text-decoration: underline;\r\n    cursor: pointer;\r\n}\r\n.footer-margin-top{\r\n    margin-top:40px\r\n}\r\nbutton.adjust-en-ch{\r\n    width: 70px;\r\n}\r\n.addone-no-radius{\r\n    border-radius: 0px;\r\n    border-left: 0;\r\n    background-color: #fff !important;\r\n}\r\n.my-input-radius-control{\r\n    border-top-right-radius: 0px;\r\n    border-bottom-right-radius: 0px;\r\n}\r\n.footer-company{\r\n    margin-top: 90px;\r\n}\r\n\r\n@media (max-width: 768px) {\r\n    .lg-font-size{\r\n        display: none;\r\n    }\r\n    .container-wrapper{\r\n        /*background-color: #136DC9;*/\r\n        /*background:url("../images/bg.png") repeat-y ;*/\r\n        color:rgb(255,255,255);\r\n        width: 100%;\r\n        /*padding-bottom: 70px;*/\r\n        margin: 0px auto;\r\n        position: relative;\r\n        top:40px;\r\n        /*border:2px solid #136DC9;*/\r\n        border-radius: 10px;\r\n    }\r\n    .my-pre-step-next-step-position{\r\n        position: relative;\r\n        /*top:350px;*/\r\n        left:30%;\r\n        width:160px\r\n    }\r\n    .addone-no-radius{\r\n        display: none;\r\n    }\r\n    .addone-margin-left{\r\n        /*margin-left: 0px;*/\r\n        padding-left: 15px;\r\n        margin-top: 20px;\r\n    }\r\n    .my-input-radius-control{\r\n        border-top-right-radius: 4px;\r\n        border-bottom-right-radius: 4px;\r\n    }\r\n    .addone-input-mobile{\r\n        border-top-left-radius: 4px !important;\r\n        border-bottom-left-radius: 4px !important;\r\n        margin-left: 15px;\r\n    }\r\n    .mask_block{\r\n        display: none!important;\r\n    }\r\n    .minify-style{\r\n        text-align: left!important;\r\n        padding-left: 0px!important;\r\n    }\r\n    .minify-margin-top{\r\n        margin-top: 25px;\r\n        padding-left: 15px;\r\n    }\r\n    .except-minify-padding{\r\n        padding-right: 15px!important;\r\n    }\r\n}\r\n@media (max-width: 992px) {\r\n    .lg-font-size{\r\n        /*display: none;*/\r\n        font-size: 26px;\r\n    }\r\n    .container-wrapper{\r\n        /*background-color: #136DC9;*/\r\n        /*background:url("../images/bg.png") repeat-y ;*/\r\n        color:rgb(255,255,255);\r\n        width: 100%;\r\n        /*padding-bottom: 70px;*/\r\n        margin: 0px auto;\r\n        position: relative;\r\n        top:40px;\r\n        /*border:2px solid #136DC9;*/\r\n        border-radius: 10px;\r\n    }\r\n    .my-pre-step-next-step-position{\r\n        position: relative;\r\n        /*top:350px;*/\r\n        left:50%;\r\n        width: 160px;\r\n    }\r\n    .except-minify-padding{\r\n        padding-right: 0px;\r\n    }\r\n}\r\n@media(min-width:993px ) {\r\n    .lg-font-size{\r\n        /*display: none;*/\r\n        font-size: 26px;\r\n    }\r\n    .my-table-checkbox{\r\n        position: absolute;\r\n        margin-left: 20px !important;\r\n    }\r\n    .my-pre-step-next-step-position{\r\n        position: absolute;\r\n        top:350px;\r\n        left:80%;\r\n        width: 160px;\r\n    }\r\n    .container-wrapper{\r\n        /*background-color: #136DC9;*/\r\n        /*background:url("../images/bg.png") repeat-y ;*/\r\n        color:rgb(255,255,255);\r\n        width: 73%;\r\n        /*padding-bottom: 70px;*/\r\n        margin: 0px auto;\r\n        position: relative;\r\n        top:40px;\r\n        /*border:2px solid #136DC9;*/\r\n        border-radius: 10px;\r\n    }\r\n    .except-minify-padding{\r\n        padding-right: 0px;\r\n    }\r\n}\r\n@media (min-width: 1200px) {\r\n    .lg-font-size{\r\n        /*display: none;*/\r\n        font-size: 40px;\r\n    }\r\n    .my-row-1{\r\n        margin-left: -87px !important;\r\n        margin-right: -7px !important;\r\n    }\r\n    .my-row-2{\r\n        margin-left: -83.5px !important;\r\n        margin-right: -3.5px !important;\r\n    }\r\n    .my-row-3{\r\n        margin-left: -87px !important;\r\n        margin-right: 0px !important;\r\n    }\r\n    .except-minify-padding{\r\n        padding-right: 0px;\r\n    }\r\n}\r\n@media(min-width: 1540px) {\r\n    .my-row-1{\r\n        margin-right: 0px !important;\r\n        margin-left: -96px !important;\r\n    }\r\n    .my-row-2{\r\n        margin-left: -96px !important;\r\n        margin-right: 4px !important\r\n    }\r\n    .my-row-3{\r\n        margin-left: -100px !important;\r\n        margin-right: 0px !important;\r\n    }\r\n    .except-minify-padding{\r\n        padding-right: 0px;\r\n    }\r\n}\r\n.footer-copyright{\r\n    line-height: 70px;\r\n    text-align: center;\r\n    font-weight: 700;\r\n}\r\n.footer-wrapper{\r\n    height: 70px;\r\n    margin-top: 48px;\r\n    text-align: center;\r\n}\r\n'
;
}), function($) {
    var methods = {
        init: function(options) {
            var form = this;
            if (!form.data("jqv") || form.data("jqv") == null) options = methods._saveOptions(form, options), $(document).on("click", ".formError", function() {
                $(this).parent(".formErrorOuter").remove(), $(this).remove();
            });
            return this;
        },
        attach: function(userOptions) {
            var form = this, options;
            return userOptions ? options = methods._saveOptions(form, userOptions) : options = form.data("jqv"), options.validateAttribute = form.find("[data-validation-engine*=validate]").length ? "data-validation-engine" : "class", options.binded && (form.on(options.validationEventTrigger, "[" + options.validateAttribute + "*=validate]:not([type=checkbox]):not([type=radio]):not(.datepicker)", methods._onFieldEvent), form.on("click", "[" + options.validateAttribute + "*=validate][type=checkbox],[" + options.validateAttribute + "*=validate][type=radio]"
, methods._onFieldEvent), form.on(options.validationEventTrigger, "[" + options.validateAttribute + "*=validate][class*=datepicker]", {
                delay: 300
            }, methods._onFieldEvent)), options.autoPositionUpdate && $(window).bind("resize", {
                noAnimation: !0,
                formElem: form
            }, methods.updatePromptsPosition), form.on("click", "a[data-validation-engine-skip], a[class*='validate-skip'], button[data-validation-engine-skip], button[class*='validate-skip'], input[data-validation-engine-skip], input[class*='validate-skip']", methods._submitButtonClick), form.removeData("jqv_submitButton"), form.on("submit", methods._onSubmitEvent), this;
        },
        detach: function() {
            var form = this, options = form.data("jqv");
            return form.find("[" + options.validateAttribute + "*=validate]").not("[type=checkbox]").off(options.validationEventTrigger, methods._onFieldEvent), form.find("[" + options.validateAttribute + "*=validate][type=checkbox],[class*=validate][type=radio]"
).off("click", methods._onFieldEvent), form.off("submit", methods._onSubmitEvent), form.removeData("jqv"), form.off("click", "a[data-validation-engine-skip], a[class*='validate-skip'], button[data-validation-engine-skip], button[class*='validate-skip'], input[data-validation-engine-skip], input[class*='validate-skip']", methods._submitButtonClick), form.removeData("jqv_submitButton"), options.autoPositionUpdate && $(window).off("resize", methods.updatePromptsPosition), this;
        },
        validate: function() {
            var element = $(this), valid = null;
            if (element.is("form") || element.hasClass("validationEngineContainer")) {
                if (element.hasClass("validating")) return !1;
                element.addClass("validating");
                var options = element.data("jqv"), valid = methods._validateFields(this);
                setTimeout(function() {
                    element.removeClass("validating");
                }, 100), valid && options.onSuccess ? 
options.onSuccess() : !valid && options.onFailure && options.onFailure();
            } else if (element.is("form") || element.hasClass("validationEngineContainer")) element.removeClass("validating"); else {
                var form = element.closest("form, .validationEngineContainer"), options = form.data("jqv") ? form.data("jqv") : $.validationEngine.defaults, valid = methods._validateField(element, options);
                valid && options.onFieldSuccess ? options.onFieldSuccess() : options.onFieldFailure && options.InvalidFields.length > 0 && options.onFieldFailure();
            }
            return options.onValidationComplete ? !!options.onValidationComplete(form, valid) : valid;
        },
        updatePromptsPosition: function(event) {
            if (event && this == window) var form = event.data.formElem, noAnimation = event.data.noAnimation; else var form = $(this.closest("form, .validationEngineContainer"));
            var options = form.data("jqv");
            return form
.find("[" + options.validateAttribute + "*=validate]").not(":disabled").each(function() {
                var field = $(this);
                options.prettySelect && field.is(":hidden") && (field = form.find("#" + options.usePrefix + field.attr("id") + options.useSuffix));
                var prompt = methods._getPrompt(field), promptText = $(prompt).find(".formErrorContent").html();
                prompt && methods._updatePrompt(field, $(prompt), promptText, undefined, !1, options, noAnimation);
            }), this;
        },
        showPrompt: function(promptText, type, promptPosition, showArrow) {
            var form = this.closest("form, .validationEngineContainer"), options = form.data("jqv");
            return options || (options = methods._saveOptions(this, options)), promptPosition && (options.promptPosition = promptPosition), options.showArrow = showArrow == 1, methods._showPrompt(this, promptText, type, !1, options), this;
        },
        hide: function() {
            
var form = $(this).closest("form, .validationEngineContainer"), options = form.data("jqv"), fadeDuration = options && options.fadeDuration ? options.fadeDuration : .3, closingtag;
            return $(this).is("form") || $(this).hasClass("validationEngineContainer") ? closingtag = "parentForm" + methods._getClassName($(this).attr("id")) : closingtag = methods._getClassName($(this).attr("id")) + "formError", $("." + closingtag).fadeTo(fadeDuration, .3, function() {
                $(this).parent(".formErrorOuter").remove(), $(this).remove();
            }), this;
        },
        hideAll: function() {
            $(".formError").remove(), $(this).parent(".formErrorOuter").remove();
        },
        _onFieldEvent: function(event) {
            var field = $(this), form = field.closest("form, .validationEngineContainer"), options = form.data("jqv");
            options.eventTrigger = "field", window.setTimeout(function() {
                methods._validateField(field, options), options
.InvalidFields.length == 0 && options.onFieldSuccess ? options.onFieldSuccess() : options.InvalidFields.length > 0 && options.onFieldFailure && options.onFieldFailure();
            }, event.data ? event.data.delay : 0);
        },
        _onSubmitEvent: function() {
            var form = $(this), options = form.data("jqv");
            if (form.data("jqv_submitButton")) {
                var submitButton = $("#" + form.data("jqv_submitButton"));
                if (submitButton && submitButton.length > 0) if (submitButton.hasClass("validate-skip") || submitButton.attr("data-validation-engine-skip") == "true") return !0;
            }
            options.eventTrigger = "submit";
            var r = methods._validateFields(form);
            return r && options.ajaxFormValidation ? (methods._validateFormWithAjax(form, options), !1) : options.onValidationComplete ? !!options.onValidationComplete(form, r) : r;
        },
        _checkAjaxStatus: function(options) {
            var status = !0
;
            return $.each(options.ajaxValidCache, function(key, value) {
                if (!value) return status = !1, !1;
            }), status;
        },
        _checkAjaxFieldStatus: function(fieldid, options) {
            return options.ajaxValidCache[fieldid] == 1;
        },
        _validateFields: function(form) {
            var options = form.data("jqv"), errorFound = !1;
            form.trigger("jqv.form.validating");
            var first_err = null;
            form.find("[" + options.validateAttribute + "*=validate]").not(":disabled").each(function() {
                var field = $(this), names = [];
                if ($.inArray(field.attr("name"), names) < 0) {
                    errorFound |= methods._validateField(field, options), errorFound && first_err == null && (field.is(":hidden") && options.prettySelect ? first_err = field = form.find("#" + options.usePrefix + methods._jqSelector(field.attr("id")) + options.useSuffix) : (field.data("jqv-prompt-at") instanceof 
jQuery ? field = field.data("jqv-prompt-at") : field.data("jqv-prompt-at") && (field = $(field.data("jqv-prompt-at"))), first_err = field));
                    if (options.doNotShowAllErrosOnSubmit) return !1;
                    names.push(field.attr("name"));
                    if (options.showOneMessage == 1 && errorFound) return !1;
                }
            }), form.trigger("jqv.form.result", [ errorFound ]);
            if (errorFound) {
                if (options.scroll) {
                    var destination = first_err.offset().top, fixleft = first_err.offset().left, positionType = options.promptPosition;
                    typeof positionType == "string" && positionType.indexOf(":") != -1 && (positionType = positionType.substring(0, positionType.indexOf(":")));
                    if (positionType != "bottomRight" && positionType != "bottomLeft") {
                        var prompt_err = methods._getPrompt(first_err);
                        prompt_err && (destination = 
prompt_err.offset().top);
                    }
                    options.scrollOffset && (destination -= options.scrollOffset);
                    if (options.isOverflown) {
                        var overflowDIV = $(options.overflownDIV);
                        if (!overflowDIV.length) return !1;
                        var scrollContainerScroll = overflowDIV.scrollTop(), scrollContainerPos = -parseInt(overflowDIV.offset().top);
                        destination += scrollContainerScroll + scrollContainerPos - 5;
                        var scrollContainer = $(options.overflownDIV + ":not(:animated)");
                        scrollContainer.animate({
                            scrollTop: destination
                        }, 1100, function() {
                            options.focusFirstField && first_err.focus();
                        });
                    } else $("html, body").animate({
                        scrollTop: destination
                    }, 1100, function(
) {
                        options.focusFirstField && first_err.focus();
                    }), $("html, body").animate({
                        scrollLeft: fixleft
                    }, 1100);
                } else options.focusFirstField && first_err.focus();
                return !1;
            }
            return !0;
        },
        _validateFormWithAjax: function(form, options) {
            var data = form.serialize(), type = options.ajaxFormValidationMethod ? options.ajaxFormValidationMethod : "GET", url = options.ajaxFormValidationURL ? options.ajaxFormValidationURL : form.attr("action"), dataType = options.dataType ? options.dataType : "json";
            $.ajax({
                type: type,
                url: url,
                cache: !1,
                dataType: dataType,
                data: data,
                form: form,
                methods: methods,
                options: options,
                beforeSend: function() {
                    return options
.onBeforeAjaxFormValidation(form, options);
                },
                error: function(data, transport) {
                    methods._ajaxError(data, transport);
                },
                success: function(json) {
                    if (dataType == "json" && json !== !0) {
                        var errorInForm = !1;
                        for (var i = 0; i < json.length; i++) {
                            var value = json[i], errorFieldId = value[0], errorField = $($("#" + errorFieldId)[0]);
                            if (errorField.length == 1) {
                                var msg = value[2];
                                if (value[1] == 1) if (msg == "" || !msg) methods._closePrompt(errorField); else {
                                    if (options.allrules[msg]) {
                                        var txt = options.allrules[msg].alertTextOk;
                                        txt && (msg = txt);
                                    }
                                    
options.showPrompts && methods._showPrompt(errorField, msg, "pass", !1, options, !0);
                                } else {
                                    errorInForm |= !0;
                                    if (options.allrules[msg]) {
                                        var txt = options.allrules[msg].alertText;
                                        txt && (msg = txt);
                                    }
                                    options.showPrompts && methods._showPrompt(errorField, msg, "", !1, options, !0);
                                }
                            }
                        }
                        options.onAjaxFormComplete(!errorInForm, form, json, options);
                    } else options.onAjaxFormComplete(!0, form, json, options);
                }
            });
        },
        _promptFlag: undefined,
        _validateField: function(field, options, skipAjaxValidation) {
            field.attr("id") || (field.attr("id", "form-validation-field-" + 
$.validationEngine.fieldIdCounter), ++$.validationEngine.fieldIdCounter);
            if (!options.validateNonVisibleFields && (field.is(":hidden") && !options.prettySelect || field.parent().is(":hidden"))) return !1;
            var rulesParsing = field.attr(options.validateAttribute), getRules = /validate\[(.*)\]/.exec(rulesParsing);
            if (!getRules) return !1;
            var str = getRules[1], rules = str.split(/\[|,|\]/), isAjaxValidator = !1, fieldName = field.attr("name"), promptText = "", promptType = "", required = !1, limitErrors = !1;
            options.isError = !1, options.showArrow = !0, options.maxErrorsPerField > 0 && (limitErrors = !0);
            var form = $(field.closest("form, .validationEngineContainer"));
            for (var i = 0; i < rules.length; i++) rules[i] = rules[i].replace(" ", ""), rules[i] === "" && delete rules[i];
            for (var i = 0, field_errors = 0; i < rules.length; i++) {
                if (limitErrors && field_errors >= options
.maxErrorsPerField) {
                    if (!required) {
                        var have_required = $.inArray("required", rules);
                        required = have_required != -1 && have_required >= i;
                    }
                    break;
                }
                var errorMsg = undefined;
                switch (rules[i]) {
                  case "required":
                    required = !0, errorMsg = methods._getErrorMessage(form, field, rules[i], rules, i, options, methods._required), methods._promptFlag = errorMsg;
                    break;
                  case "custom":
                    var index = rules.indexOf("required"), tempArr, tempArr_1, tempArr_2;
                    index != -1 ? (tempArr_1 = rules.slice(0, index), tempArr_2 = rules.slice(index + 1), tempArr = tempArr_1.concat(tempArr_2)) : tempArr = rules, typeof methods._promptFlag != "undefined" && (index != -1 || index == -1 && tempArr[0] !== rules[i]) ? errorMsg = undefined : (errorMsg = 
methods._getErrorMessage(form, field, rules[i], rules, i, options, methods._custom), methods._promptFlag = errorMsg);
                    break;
                  case "groupRequired":
                    var classGroup = "[" + options.validateAttribute + "*=" + rules[i + 1] + "]", firstOfGroup = form.find(classGroup).eq(0);
                    firstOfGroup[0] != field[0] && (methods._validateField(firstOfGroup, options, skipAjaxValidation), options.showArrow = !0), errorMsg = methods._getErrorMessage(form, field, rules[i], rules, i, options, methods._groupRequired), errorMsg && (required = !0), options.showArrow = !1;
                    break;
                  case "ajax":
                    errorMsg = methods._ajax(field, rules, i, options), errorMsg && (promptType = "load");
                    break;
                  case "minSize":
                    typeof methods._promptFlag != "undefined" ? errorMsg = undefined : (errorMsg = methods._getErrorMessage(form, field, rules[i], rules
, i, options, methods._minSize), methods._promptFlag = errorMsg);
                    break;
                  case "maxSize":
                    typeof methods._promptFlag != "undefined" ? errorMsg = undefined : (errorMsg = methods._getErrorMessage(form, field, rules[i], rules, i, options, methods._maxSize), methods._promptFlag = errorMsg);
                    break;
                  case "min":
                    errorMsg = methods._getErrorMessage(form, field, rules[i], rules, i, options, methods._min);
                    break;
                  case "max":
                    errorMsg = methods._getErrorMessage(form, field, rules[i], rules, i, options, methods._max);
                    break;
                  case "past":
                    errorMsg = methods._getErrorMessage(form, field, rules[i], rules, i, options, methods._past);
                    break;
                  case "future":
                    errorMsg = methods._getErrorMessage(form, field, rules[i], rules
, i, options, methods._future);
                    break;
                  case "dateRange":
                    var classGroup = "[" + options.validateAttribute + "*=" + rules[i + 1] + "]";
                    options.firstOfGroup = form.find(classGroup).eq(0), options.secondOfGroup = form.find(classGroup).eq(1);
                    if (options.firstOfGroup[0].value || options.secondOfGroup[0].value) errorMsg = methods._getErrorMessage(form, field, rules[i], rules, i, options, methods._dateRange);
                    errorMsg && (required = !0), options.showArrow = !1;
                    break;
                  case "dateTimeRange":
                    var classGroup = "[" + options.validateAttribute + "*=" + rules[i + 1] + "]";
                    options.firstOfGroup = form.find(classGroup).eq(0), options.secondOfGroup = form.find(classGroup).eq(1);
                    if (options.firstOfGroup[0].value || options.secondOfGroup[0].value) errorMsg = methods._getErrorMessage(form, field
, rules[i], rules, i, options, methods._dateTimeRange);
                    errorMsg && (required = !0), options.showArrow = !1;
                    break;
                  case "maxCheckbox":
                    field = $(form.find("input[name='" + fieldName + "']")), errorMsg = methods._getErrorMessage(form, field, rules[i], rules, i, options, methods._maxCheckbox);
                    break;
                  case "minCheckbox":
                    field = $(form.find("input[name='" + fieldName + "']")), errorMsg = methods._getErrorMessage(form, field, rules[i], rules, i, options, methods._minCheckbox);
                    break;
                  case "equals":
                    typeof methods._promptFlag != "undefined" ? errorMsg = undefined : (errorMsg = methods._getErrorMessage(form, field, rules[i], rules, i, options, methods._equals), methods._promptFlag = errorMsg);
                    break;
                  case "funcCall":
                    errorMsg = methods._getErrorMessage
(form, field, rules[i], rules, i, options, methods._funcCall);
                    break;
                  case "creditCard":
                    errorMsg = methods._getErrorMessage(form, field, rules[i], rules, i, options, methods._creditCard);
                    break;
                  case "condRequired":
                    errorMsg = methods._getErrorMessage(form, field, rules[i], rules, i, options, methods._condRequired), errorMsg !== undefined && (required = !0);
                    break;
                  default:
                }
                var end_validation = !1;
                if (typeof errorMsg == "object") switch (errorMsg.status) {
                  case "_break":
                    end_validation = !0;
                    break;
                  case "_error":
                    errorMsg = errorMsg.message;
                    break;
                  case "_error_no_prompt":
                    return !0;
                  default:
                }
                
if (end_validation) break;
                typeof errorMsg == "string" && (promptText += errorMsg + "<br/>", options.isError = !0, field_errors++);
            }
            !required && !field.val() && field.val().length < 1 && (options.isError = !1);
            var fieldType = field.prop("type"), positionType = field.data("promptPosition") || options.promptPosition;
            (fieldType == "radio" || fieldType == "checkbox") && form.find("input[name='" + fieldName + "']").size() > 1 && (positionType === "inline" ? field = $(form.find("input[name='" + fieldName + "'][type!=hidden]:last")) : field = $(form.find("input[name='" + fieldName + "'][type!=hidden]:first")), options.showArrow = !1), field.is(":hidden") && options.prettySelect && (field = form.find("#" + options.usePrefix + methods._jqSelector(field.attr("id")) + options.useSuffix)), options.isError && options.showPrompts ? methods._showPrompt(field, promptText, promptType, !1, options) : isAjaxValidator || methods._closePrompt
(field), isAjaxValidator || field.trigger("jqv.field.result", [ field, options.isError, promptText ]);
            var errindex = $.inArray(field[0], options.InvalidFields);
            return errindex == -1 ? options.isError && options.InvalidFields.push(field[0]) : options.isError || options.InvalidFields.splice(errindex, 1), methods._handleStatusCssClasses(field, options), options.isError && options.onFieldFailure && options.onFieldFailure(field), !options.isError && options.onFieldSuccess && options.onFieldSuccess(field), options.isError;
        },
        _handleStatusCssClasses: function(field, options) {
            options.addSuccessCssClassToField && field.removeClass(options.addSuccessCssClassToField), options.addFailureCssClassToField && field.removeClass(options.addFailureCssClassToField), options.addSuccessCssClassToField && !options.isError && field.addClass(options.addSuccessCssClassToField), options.addFailureCssClassToField && options.isError && field.addClass(options.
addFailureCssClassToField);
        },
        _getErrorMessage: function(form, field, rule, rules, i, options, originalValidationMethod) {
            var rule_index = jQuery.inArray(rule, rules);
            if (rule === "custom" || rule === "funcCall") {
                var custom_validation_type = rules[rule_index + 1];
                rule = rule + "[" + custom_validation_type + "]", delete rules[rule_index];
            }
            var alteredRule = rule, element_classes = field.attr("data-validation-engine") ? field.attr("data-validation-engine") : field.attr("class"), element_classes_array = element_classes.split(" "), errorMsg;
            rule == "future" || rule == "past" || rule == "maxCheckbox" || rule == "minCheckbox" ? errorMsg = originalValidationMethod(form, field, rules, i, options) : errorMsg = originalValidationMethod(field, rules, i, options);
            if (errorMsg != undefined) {
                var custom_message = methods._getCustomErrorMessage($(field), element_classes_array
, alteredRule, options);
                custom_message && (errorMsg = custom_message);
            }
            return errorMsg;
        },
        _getCustomErrorMessage: function(field, classes, rule, options) {
            var custom_message = !1, validityProp = /^custom\[.*\]$/.test(rule) ? methods._validityProp.custom : methods._validityProp[rule];
            if (validityProp != undefined) {
                custom_message = field.attr("data-errormessage-" + validityProp);
                if (custom_message != undefined) return custom_message;
            }
            custom_message = field.attr("data-errormessage");
            if (custom_message != undefined) return custom_message;
            var id = "#" + field.attr("id");
            if (typeof options.custom_error_messages[id] != "undefined" && typeof options.custom_error_messages[id][rule] != "undefined") custom_message = options.custom_error_messages[id][rule].message; else if (classes.length > 0) for (var i = 0; i < classes
.length && classes.length > 0; i++) {
                var element_class = "." + classes[i];
                if (typeof options.custom_error_messages[element_class] != "undefined" && typeof options.custom_error_messages[element_class][rule] != "undefined") {
                    custom_message = options.custom_error_messages[element_class][rule].message;
                    break;
                }
            }
            return !custom_message && typeof options.custom_error_messages[rule] != "undefined" && typeof options.custom_error_messages[rule]["message"] != "undefined" && (custom_message = options.custom_error_messages[rule].message), custom_message;
        },
        _validityProp: {
            required: "value-missing",
            custom: "custom-error",
            groupRequired: "value-missing",
            ajax: "custom-error",
            minSize: "range-underflow",
            maxSize: "range-overflow",
            min: "range-underflow",
            max: "range-overflow"
,
            past: "type-mismatch",
            future: "type-mismatch",
            dateRange: "type-mismatch",
            dateTimeRange: "type-mismatch",
            maxCheckbox: "range-overflow",
            minCheckbox: "range-underflow",
            equals: "pattern-mismatch",
            funcCall: "custom-error",
            creditCard: "pattern-mismatch",
            condRequired: "value-missing"
        },
        _required: function(field, rules, i, options, condRequired) {
            switch (field.prop("type")) {
              case "text":
              case "password":
              case "textarea":
              case "file":
              case "select-one":
              case "select-multiple":
              default:
                var field_val = $.trim(field.val()), dv_placeholder = $.trim(field.attr("data-validation-placeholder")), placeholder = $.trim(field.attr("placeholder"));
                if (!field_val || dv_placeholder && field_val == dv_placeholder || placeholder && 
field_val == placeholder) return options.allrules[rules[i]].alertText;
                break;
              case "radio":
              case "checkbox":
                if (condRequired) {
                    if (!field.attr("checked")) return options.allrules[rules[i]].alertTextCheckboxMultiple;
                    break;
                }
                var form = field.closest("form, .validationEngineContainer"), name = field.attr("name");
                if (form.find("input[name='" + name + "']:checked").size() == 0) return form.find("input[name='" + name + "']:visible").size() == 1 ? options.allrules[rules[i]].alertTextCheckboxe : options.allrules[rules[i]].alertTextCheckboxMultiple;
            }
        },
        _groupRequired: function(field, rules, i, options) {
            var classGroup = "[" + options.validateAttribute + "*=" + rules[i + 1] + "]", isValid = !1;
            field.closest("form, .validationEngineContainer").find(classGroup).each(function() {
                
if (!methods._required($(this), rules, i, options)) return isValid = !0, !1;
            });
            if (!isValid) return options.allrules[rules[i]].alertText;
        },
        _custom: function(field, rules, i, options) {
            var customRule = rules[i + 1], rule = options.allrules[customRule], fn;
            if (!rule) {
                alert("jqv:custom rule not found - " + customRule);
                return;
            }
            if (rule.regex) {
                var ex = rule.regex;
                if (!ex) {
                    alert("jqv:custom regex not found - " + customRule);
                    return;
                }
                var pattern = new RegExp(ex);
                if (!pattern.test(field.val())) return options.allrules[customRule].alertText;
            } else {
                if (!rule.func) {
                    alert("jqv:custom type not allowed " + customRule);
                    return;
                }
                fn = rule.func
;
                if (typeof fn != "function") {
                    alert("jqv:custom parameter 'function' is no function - " + customRule);
                    return;
                }
                if (!fn(field, rules, i, options)) return options.allrules[customRule].alertText;
            }
        },
        _funcCall: function(field, rules, i, options) {
            var functionName = rules[i + 1], fn;
            if (functionName.indexOf(".") > -1) {
                var namespaces = functionName.split("."), scope = window;
                while (namespaces.length) scope = scope[namespaces.shift()];
                fn = scope;
            } else fn = window[functionName] || options.customFunctions[functionName];
            if (typeof fn == "function") return fn(field, rules, i, options);
        },
        _equals: function(field, rules, i, options) {
            var equalsField = rules[i + 1];
            if (field.val() != $("#" + equalsField).val()) return options.allrules
.equals.alertText;
        },
        _maxSize: function(field, rules, i, options) {
            var max = rules[i + 1], len = field.val().length;
            if (len > max) {
                var rule = options.allrules.maxSize;
                return rule.alertText + max + rule.alertText2;
            }
        },
        _minSize: function(field, rules, i, options) {
            var min = rules[i + 1], len = field.val().length;
            if (len < min) {
                var rule = options.allrules.minSize;
                return rule.alertText + min + rule.alertText2;
            }
        },
        _min: function(field, rules, i, options) {
            var min = parseFloat(rules[i + 1]), len = parseFloat(field.val());
            if (len < min) {
                var rule = options.allrules.min;
                return rule.alertText2 ? rule.alertText + min + rule.alertText2 : rule.alertText + min;
            }
        },
        _max: function(field, rules, i, options) {
            
var max = parseFloat(rules[i + 1]), len = parseFloat(field.val());
            if (len > max) {
                var rule = options.allrules.max;
                return rule.alertText2 ? rule.alertText + max + rule.alertText2 : rule.alertText + max;
            }
        },
        _past: function(form, field, rules, i, options) {
            var p = rules[i + 1], fieldAlt = $(form.find("input[name='" + p.replace(/^#+/, "") + "']")), pdate;
            if (p.toLowerCase() == "now") pdate = new Date; else if (undefined != fieldAlt.val()) {
                if (fieldAlt.is(":disabled")) return;
                pdate = methods._parseDate(fieldAlt.val());
            } else pdate = methods._parseDate(p);
            var vdate = methods._parseDate(field.val());
            if (vdate > pdate) {
                var rule = options.allrules.past;
                return rule.alertText2 ? rule.alertText + methods._dateToString(pdate) + rule.alertText2 : rule.alertText + methods._dateToString(pdate);
            
}
        },
        _future: function(form, field, rules, i, options) {
            var p = rules[i + 1], fieldAlt = $(form.find("input[name='" + p.replace(/^#+/, "") + "']")), pdate;
            if (p.toLowerCase() == "now") pdate = new Date; else if (undefined != fieldAlt.val()) {
                if (fieldAlt.is(":disabled")) return;
                pdate = methods._parseDate(fieldAlt.val());
            } else pdate = methods._parseDate(p);
            var vdate = methods._parseDate(field.val());
            if (vdate < pdate) {
                var rule = options.allrules.future;
                return rule.alertText2 ? rule.alertText + methods._dateToString(pdate) + rule.alertText2 : rule.alertText + methods._dateToString(pdate);
            }
        },
        _isDate: function(value) {
            var dateRegEx = new RegExp(/^\d{4}[\/\-](0?[1-9]|1[012])[\/\-](0?[1-9]|[12][0-9]|3[01])$|^(?:(?:(?:0?[13578]|1[02])(\/|-)31)|(?:(?:0?[1,3-9]|1[0-2])(\/|-)(?:29|30)))(\/|-)(?:[1-9]\d\d\d|\d[1-9]\d\d|\d\d[1-9]\d|\d\d\d[1-9])$|^(?:(?:0?[1-9]|1[0-2])(\/|-)(?:0?[1-9]|1\d|2[0-8]))(\/|-)(?:[1-9]\d\d\d|\d[1-9]\d\d|\d\d[1-9]\d|\d\d\d[1-9])$|^(0?2(\/|-)29)(\/|-)(?:(?:0[48]00|[13579][26]00|[2468][048]00)|(?:\d\d)?(?:0[48]|[2468][048]|[13579][26]))$/
);
            return dateRegEx.test(value);
        },
        _isDateTime: function(value) {
            var dateTimeRegEx = new RegExp(/^\d{4}[\/\-](0?[1-9]|1[012])[\/\-](0?[1-9]|[12][0-9]|3[01])\s+(1[012]|0?[1-9]){1}:(0?[1-5]|[0-6][0-9]){1}:(0?[0-6]|[0-6][0-9]){1}\s+(am|pm|AM|PM){1}$|^(?:(?:(?:0?[13578]|1[02])(\/|-)31)|(?:(?:0?[1,3-9]|1[0-2])(\/|-)(?:29|30)))(\/|-)(?:[1-9]\d\d\d|\d[1-9]\d\d|\d\d[1-9]\d|\d\d\d[1-9])$|^((1[012]|0?[1-9]){1}\/(0?[1-9]|[12][0-9]|3[01]){1}\/\d{2,4}\s+(1[012]|0?[1-9]){1}:(0?[1-5]|[0-6][0-9]){1}:(0?[0-6]|[0-6][0-9]){1}\s+(am|pm|AM|PM){1})$/);
            return dateTimeRegEx.test(value);
        },
        _dateCompare: function(start, end) {
            return new Date(start.toString()) < new Date(end.toString());
        },
        _dateRange: function(field, rules, i, options) {
            if (!options.firstOfGroup[0].value && options.secondOfGroup[0].value || options.firstOfGroup[0].value && !options.secondOfGroup[0].value) return options.allrules[rules
[i]].alertText + options.allrules[rules[i]].alertText2;
            if (!methods._isDate(options.firstOfGroup[0].value) || !methods._isDate(options.secondOfGroup[0].value)) return options.allrules[rules[i]].alertText + options.allrules[rules[i]].alertText2;
            if (!methods._dateCompare(options.firstOfGroup[0].value, options.secondOfGroup[0].value)) return options.allrules[rules[i]].alertText + options.allrules[rules[i]].alertText2;
        },
        _dateTimeRange: function(field, rules, i, options) {
            if (!options.firstOfGroup[0].value && options.secondOfGroup[0].value || options.firstOfGroup[0].value && !options.secondOfGroup[0].value) return options.allrules[rules[i]].alertText + options.allrules[rules[i]].alertText2;
            if (!methods._isDateTime(options.firstOfGroup[0].value) || !methods._isDateTime(options.secondOfGroup[0].value)) return options.allrules[rules[i]].alertText + options.allrules[rules[i]].alertText2;
            if (!methods._dateCompare(options
.firstOfGroup[0].value, options.secondOfGroup[0].value)) return options.allrules[rules[i]].alertText + options.allrules[rules[i]].alertText2;
        },
        _maxCheckbox: function(form, field, rules, i, options) {
            var nbCheck = rules[i + 1], groupname = field.attr("name"), groupSize = form.find("input[name='" + groupname + "']:checked").size();
            if (groupSize > nbCheck) return options.showArrow = !1, options.allrules.maxCheckbox.alertText2 ? options.allrules.maxCheckbox.alertText + " " + nbCheck + " " + options.allrules.maxCheckbox.alertText2 : options.allrules.maxCheckbox.alertText;
        },
        _minCheckbox: function(form, field, rules, i, options) {
            var nbCheck = rules[i + 1], groupname = field.attr("name"), groupSize = form.find("input[name='" + groupname + "']:checked").size();
            if (groupSize < nbCheck) return options.showArrow = !1, options.allrules.minCheckbox.alertText + " " + nbCheck + " " + options.allrules.minCheckbox.alertText2
;
        },
        _creditCard: function(field, rules, i, options) {
            var valid = !1, cardNumber = field.val().replace(/ +/g, "").replace(/-+/g, ""), numDigits = cardNumber.length;
            if (numDigits >= 14 && numDigits <= 16 && parseInt(cardNumber) > 0) {
                var sum = 0, i = numDigits - 1, pos = 1, digit, luhn = new String;
                do digit = parseInt(cardNumber.charAt(i)), luhn += pos++ % 2 == 0 ? digit * 2 : digit; while (--i >= 0);
                for (i = 0; i < luhn.length; i++) sum += parseInt(luhn.charAt(i));
                valid = sum % 10 == 0;
            }
            if (!valid) return options.allrules.creditCard.alertText;
        },
        _ajax: function(field, rules, i, options) {
            var errorSelector = rules[i + 1], rule = options.allrules[errorSelector], extraData = rule.extraData, extraDataDynamic = rule.extraDataDynamic, data = {
                fieldId: field.attr("id"),
                fieldValue: field.val()
            
};
            if (typeof extraData == "object") $.extend(data, extraData); else if (typeof extraData == "string") {
                var tempData = extraData.split("&");
                for (var i = 0; i < tempData.length; i++) {
                    var values = tempData[i].split("=");
                    values[0] && values[0] && (data[values[0]] = values[1]);
                }
            }
            if (extraDataDynamic) {
                var tmpData = [], domIds = String(extraDataDynamic).split(",");
                for (var i = 0; i < domIds.length; i++) {
                    var id = domIds[i];
                    if ($(id).length) {
                        var inputValue = field.closest("form, .validationEngineContainer").find(id).val(), keyValue = id.replace("#", "") + "=" + escape(inputValue);
                        data[id.replace("#", "")] = inputValue;
                    }
                }
            }
            options.eventTrigger == "field" && delete options.ajaxValidCache
[field.attr("id")];
            if (!options.isError && !methods._checkAjaxFieldStatus(field.attr("id"), options)) return $.ajax({
                type: options.ajaxFormValidationMethod,
                url: rule.url,
                cache: !1,
                dataType: "json",
                data: data,
                field: field,
                rule: rule,
                methods: methods,
                options: options,
                beforeSend: function() {},
                error: function(data, transport) {
                    methods._ajaxError(data, transport);
                },
                success: function(json) {
                    var errorFieldId = json[0], errorField = $("#" + errorFieldId).eq(0);
                    if (errorField.length == 1) {
                        var status = json[1], msg = json[2];
                        if (!status) {
                            options.ajaxValidCache[errorFieldId] = !1, options.isError = !0;
                            
if (msg) {
                                if (options.allrules[msg]) {
                                    var txt = options.allrules[msg].alertText;
                                    txt && (msg = txt);
                                }
                            } else msg = rule.alertText;
                            options.showPrompts && methods._showPrompt(errorField, msg, "", !0, options);
                        } else {
                            options.ajaxValidCache[errorFieldId] = !0;
                            if (msg) {
                                if (options.allrules[msg]) {
                                    var txt = options.allrules[msg].alertTextOk;
                                    txt && (msg = txt);
                                }
                            } else msg = rule.alertTextOk;
                            options.showPrompts && (msg ? methods._showPrompt(errorField, msg, "pass", !0, options) : methods._closePrompt(errorField)), options.eventTrigger == "submit" && 
field.closest("form").submit();
                        }
                    }
                    errorField.trigger("jqv.field.result", [ errorField, options.isError, msg ]);
                }
            }), rule.alertTextLoad;
        },
        _ajaxError: function(data, transport) {
            data.status == 0 && transport == null ? alert("The page is not served from a server! ajax call failed") : typeof console != "undefined" && console.log("Ajax error: " + data.status + " " + transport);
        },
        _dateToString: function(date) {
            return date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate();
        },
        _parseDate: function(d) {
            var dateParts = d.split("-");
            return dateParts == d && (dateParts = d.split("/")), dateParts == d ? (dateParts = d.split("."), new Date(dateParts[2], dateParts[1] - 1, dateParts[0])) : new Date(dateParts[0], dateParts[1] - 1, dateParts[2]);
        },
        _showPrompt: function(field
, promptText, type, ajaxed, options, ajaxform) {
            field.data("jqv-prompt-at") instanceof jQuery ? field = field.data("jqv-prompt-at") : field.data("jqv-prompt-at") && (field = $(field.data("jqv-prompt-at")));
            var prompt = methods._getPrompt(field);
            ajaxform && (prompt = !1), $.trim(promptText) && (prompt ? methods._updatePrompt(field, prompt, promptText, type, ajaxed, options) : methods._buildPrompt(field, promptText, type, ajaxed, options));
        },
        _buildPrompt: function(field, promptText, type, ajaxed, options) {
            var prompt = $("<div>");
            prompt.addClass(methods._getClassName(field.attr("id")) + "formError"), prompt.addClass("parentForm" + methods._getClassName(field.closest("form, .validationEngineContainer").attr("id"))), prompt.addClass("formError");
            switch (type) {
              case "pass":
                prompt.addClass("greenPopup");
                break;
              case "load":
                
prompt.addClass("blackPopup");
                break;
              default:
            }
            ajaxed && prompt.addClass("ajaxed");
            var promptContent = $("<div>").addClass("formErrorContent").html(promptText).appendTo(prompt), positionType = field.data("promptPosition") || options.promptPosition;
            if (options.showArrow) {
                var arrow = $("<div>").addClass("formErrorArrow");
                if (typeof positionType == "string") {
                    var pos = positionType.indexOf(":");
                    pos != -1 && (positionType = positionType.substring(0, pos));
                }
                switch (positionType) {
                  case "bottomLeft":
                  case "bottomRight":
                    prompt.find(".formErrorContent").before(arrow), arrow.addClass("formErrorArrowBottom").html('<div class="line1"><!-- --></div><div class="line2"><!-- --></div><div class="line3"><!-- --></div><div class="line4"><!-- --></div><div class="line5"><!-- --></div><div class="line6"><!-- --></div><div class="line7"><!-- --></div><div class="line8"><!-- --></div><div class="line9"><!-- --></div><div class="line10"><!-- --></div>'
);
                    break;
                  case "topLeft":
                  case "topRight":
                    arrow.html('<div class="line10"><!-- --></div><div class="line9"><!-- --></div><div class="line8"><!-- --></div><div class="line7"><!-- --></div><div class="line6"><!-- --></div><div class="line5"><!-- --></div><div class="line4"><!-- --></div><div class="line3"><!-- --></div><div class="line2"><!-- --></div><div class="line1"><!-- --></div>'), prompt.append(arrow);
                }
            }
            options.addPromptClass && prompt.addClass(options.addPromptClass);
            var requiredOverride = field.attr("data-required-class");
            if (requiredOverride !== undefined) prompt.addClass(requiredOverride); else if (options.prettySelect && $("#" + field.attr("id")).next().is("select")) {
                var prettyOverrideClass = $("#" + field.attr("id").substr(options.usePrefix.length).substring(options.useSuffix.length)).attr("data-required-class");
                
prettyOverrideClass !== undefined && prompt.addClass(prettyOverrideClass);
            }
            prompt.css({
                opacity: 0
            }), positionType === "inline" ? (prompt.addClass("inline"), typeof field.attr("data-prompt-target") != "undefined" && $("#" + field.attr("data-prompt-target")).length > 0 ? prompt.appendTo($("#" + field.attr("data-prompt-target"))) : field.after(prompt)) : field.before(prompt);
            var pos = methods._calculatePosition(field, prompt, options);
            return prompt.css({
                position: positionType === "inline" ? "relative" : "absolute",
                top: pos.callerTopPosition,
                left: pos.callerleftPosition,
                marginTop: pos.marginTopSize,
                opacity: 0
            }).data("callerField", field), options.autoHidePrompt && setTimeout(function() {
                prompt.animate({
                    opacity: 0
                }, function() {
                    prompt.closest
(".formErrorOuter").remove(), prompt.remove();
                });
            }, options.autoHideDelay), prompt.animate({
                opacity: .87
            });
        },
        _updatePrompt: function(field, prompt, promptText, type, ajaxed, options, noAnimation) {
            if (prompt) {
                typeof type != "undefined" && (type == "pass" ? prompt.addClass("greenPopup") : prompt.removeClass("greenPopup"), type == "load" ? prompt.addClass("blackPopup") : prompt.removeClass("blackPopup")), ajaxed ? prompt.addClass("ajaxed") : prompt.removeClass("ajaxed"), prompt.find(".formErrorContent").html(promptText);
                var pos = methods._calculatePosition(field, prompt, options), css = {
                    top: pos.callerTopPosition,
                    left: pos.callerleftPosition,
                    marginTop: pos.marginTopSize
                };
                noAnimation ? prompt.css(css) : prompt.animate(css);
            }
        },
        _closePrompt: 
function(field) {
            var prompt = methods._getPrompt(field);
            prompt && prompt.fadeTo("fast", 0, function() {
                prompt.parent(".formErrorOuter").remove(), prompt.remove();
            });
        },
        closePrompt: function(field) {
            return methods._closePrompt(field);
        },
        _getPrompt: function(field) {
            var formId = $(field).closest("form, .validationEngineContainer").attr("id"), className = methods._getClassName(field.attr("id")) + "formError", match = $("." + methods._escapeExpression(className) + ".parentForm" + methods._getClassName(formId))[0];
            if (match) return $(match);
        },
        _escapeExpression: function(selector) {
            return selector.replace(/([#;&,\.\+\*\~':"\!\^$\[\]\(\)=>\|])/g, "\\$1");
        },
        isRTL: function(field) {
            var $document = $(document), $body = $("body"), rtl = field && field.hasClass("rtl") || field && (field.attr("dir") || "").toLowerCase
() === "rtl" || $document.hasClass("rtl") || ($document.attr("dir") || "").toLowerCase() === "rtl" || $body.hasClass("rtl") || ($body.attr("dir") || "").toLowerCase() === "rtl";
            return Boolean(rtl);
        },
        _calculatePosition: function(field, promptElmt, options) {
            var promptTopPosition, promptleftPosition, marginTopSize, fieldWidth = field.width(), fieldLeft = field.position().left, fieldTop = field.position().top, fieldHeight = field.height(), promptHeight = promptElmt.height();
            promptTopPosition = promptleftPosition = 0, marginTopSize = -promptHeight;
            var positionType = field.data("promptPosition") || options.promptPosition, shift1 = "", shift2 = "", shiftX = 0, shiftY = 0;
            typeof positionType == "string" && positionType.indexOf(":") != -1 && (shift1 = positionType.substring(positionType.indexOf(":") + 1), positionType = positionType.substring(0, positionType.indexOf(":")), shift1.indexOf(",") != -1 && (shift2 = shift1
.substring(shift1.indexOf(",") + 1), shift1 = shift1.substring(0, shift1.indexOf(",")), shiftY = parseInt(shift2), isNaN(shiftY) && (shiftY = 0)), shiftX = parseInt(shift1), isNaN(shift1) && (shift1 = 0));
            switch (positionType) {
              default:
              case "topRight":
                promptleftPosition += fieldLeft + fieldWidth - 30, promptTopPosition += fieldTop;
                break;
              case "topLeft":
                promptTopPosition += fieldTop, promptleftPosition += fieldLeft;
                break;
              case "centerRight":
                promptTopPosition = fieldTop + 4, marginTopSize = 0, promptleftPosition = fieldLeft + field.outerWidth(!0) + 5;
                break;
              case "centerLeft":
                promptleftPosition = fieldLeft - (promptElmt.width() + 2), promptTopPosition = fieldTop + 4, marginTopSize = 0;
                break;
              case "bottomLeft":
                promptTopPosition = fieldTop + field
.height() + 5, marginTopSize = 0, promptleftPosition = fieldLeft;
                break;
              case "bottomRight":
                promptleftPosition = fieldLeft + fieldWidth - 30, promptTopPosition = fieldTop + field.height() + 5, marginTopSize = 0;
                break;
              case "inline":
                promptleftPosition = 0, promptTopPosition = 0, marginTopSize = 0;
            }
            return promptleftPosition += shiftX, promptTopPosition += shiftY, {
                callerTopPosition: promptTopPosition + "px",
                callerleftPosition: promptleftPosition + "px",
                marginTopSize: marginTopSize + "px"
            };
        },
        _saveOptions: function(form, options) {
            if ($.validationEngineLanguage) var allRules = $.validationEngineLanguage.allRules; else $.error("jQuery.validationEngine rules are not loaded, plz add localization files to the page");
            $.validationEngine.defaults.allrules = allRules;
            
var userOptions = $.extend(!0, {}, $.validationEngine.defaults, options);
            return form.data("jqv", userOptions), userOptions;
        },
        _getClassName: function(className) {
            if (className) return className.replace(/:/g, "_").replace(/\./g, "_");
        },
        _jqSelector: function(str) {
            return str.replace(/([;&,\.\+\*\~':"\!\^#$%@\[\]\(\)=>\|])/g, "\\$1");
        },
        _condRequired: function(field, rules, i, options) {
            var idx, dependingField;
            for (idx = i + 1; idx < rules.length; idx++) {
                dependingField = jQuery("#" + rules[idx]).first();
                if (dependingField.length && methods._required(dependingField, [ "required" ], 0, options, true) == undefined) return methods._required(field, [ "required" ], 0, options);
            }
        },
        _submitButtonClick: function(event) {
            var button = $(this), form = button.closest("form, .validationEngineContainer");
            
form.data("jqv_submitButton", button.attr("id"));
        }
    };
    $.fn.validationEngine = function(method) {
        var form = $(this);
        if (!form[0]) return form;
        if (typeof method == "string" && method.charAt(0) != "_" && methods[method]) return method != "showPrompt" && method != "hide" && method != "hideAll" && methods.init.apply(form), methods[method].apply(form, Array.prototype.slice.call(arguments, 1));
        if (typeof method == "object" || !method) return methods.init.apply(form, arguments), methods.attach.apply(form);
        $.error("Method " + method + " does not exist in jQuery.validationEngine");
    }, $.validationEngine = {
        fieldIdCounter: 0,
        defaults: {
            validationEventTrigger: "blur",
            scroll: !0,
            focusFirstField: !0,
            showPrompts: !0,
            validateNonVisibleFields: !1,
            promptPosition: "topRight",
            bindMethod: "bind",
            inlineAjax: !1,
            
ajaxFormValidation: !1,
            ajaxFormValidationURL: !1,
            ajaxFormValidationMethod: "get",
            onAjaxFormComplete: $.noop,
            onBeforeAjaxFormValidation: $.noop,
            onValidationComplete: !1,
            doNotShowAllErrosOnSubmit: !1,
            custom_error_messages: {},
            binded: !0,
            showArrow: !0,
            isError: !1,
            maxErrorsPerField: !1,
            ajaxValidCache: {},
            autoPositionUpdate: !1,
            InvalidFields: [],
            onFieldSuccess: !1,
            onFieldFailure: !1,
            onSuccess: !1,
            onFailure: !1,
            validateAttribute: "class",
            addSuccessCssClassToField: "",
            addFailureCssClassToField: "",
            autoHidePrompt: !1,
            autoHideDelay: 1e4,
            fadeDuration: .3,
            prettySelect: !1,
            addPromptClass: "",
            usePrefix: "",
            useSuffix: "",
            showOneMessage
: !1
        }
    }, $(function() {
        $.validationEngine.defaults.promptPosition = methods.isRTL() ? "topLeft" : "topRight";
    });
}(jQuery), define("lib/jquery.validationEngine", function() {}), define("tool/validator", [ "require", "lib/jquery.validationEngine" ], function(require) {
    require("lib/jquery.validationEngine");
    var validator = {
        storageLang: null,
        langPacks: {},
        element: null,
        elements: [],
        validation: null,
        render: function(element, paramObj) {
            this._cacheElements(element, paramObj), this._cacheStorageLang(), this._render();
        },
        _cacheStorageLang: function() {
            var lang = this._returnStorageLang();
            this.storageLang ? this.storageLang != lang && (this.storageLang = lang ? lang : "zh_CN") : this.storageLang = lang ? lang : "zh_CN";
        },
        _cacheElements: function(element, paramObj) {
            var self = this;
            this.element = element;
            
var elements = this.elements, defaultObj = {
                fadeDuration: 0,
                showOneMessage: !0,
                focusFirstField: !0,
                customFunctions: {
                    cloudInput: function(field, rules, i, options) {
                        var nohtml = new RegExp("(<[^>]+>)|(&gt|&lt|&amp|&quot|&nbsp)");
                        return nohtml.test(field.val()) ? options.allrules.nohtml.alertText : !0;
                    }
                }
            };
            paramObj = $.extend(paramObj, defaultObj);
            if (elements.length > 0) {
                var count = 0;
                $.each(elements, function(index, obj) {
                    if (element == obj.element) {
                        var currentParamObj = obj.paramObj, newParamObj = $.extend(currentParamObj, paramObj);
                        self.elements[index].paramObj = newParamObj, count++;
                    }
                }), count === 0 && this.elements.push({
                    
element: element,
                    paramObj: paramObj
                });
            } else this.elements.push({
                element: element,
                paramObj: paramObj
            });
        },
        result: function(element) {
            if (this.validation) return element ? $(element).validationEngine("validate") : $(this.element).validationEngine("validate");
        },
        prompt: function(element, obj) {
            $(element).validationEngine("showPrompt", obj.text, "load", obj.promptPosition ? obj.promptPosition : "topLeft", !0);
        },
        hide: function(element) {
            element ? $(element).validationEngine("hide") : $(this.element).validationEngine("hide");
        },
        hideAll: function(element) {
            if (element) $(element).validationEngine("hideAll"); else {
                var elements = this.elements;
                this.validation && $.each(elements, function(index, obj) {
                    $(obj.element).validationEngine
("hideAll");
                });
            }
        },
        _destroy: function() {
            var elements = this.elements;
            this.validation && (this.validation = null, $.each(elements, function(index, obj) {
                $(obj.element).validationEngine("detach");
            }));
        },
        _render: function() {
            var storageLang = this.storageLang, hasPack = function() {
                var langPacks = self.langPacks;
                for (var attr in langPacks) if (attr == storageLang) return !0;
            };
            hasPack() ? this._renderForm() : this._loadPack();
        },
        _returnStorageLang: function() {
            return localStorage.getItem("language");
        },
        _renderForm: function() {
            var self = this, elements = this.elements;
            self._returnAllRules(), $.each(elements, function(index, obj) {
                self.validation = $(obj.element).validationEngine("attach", obj.paramObj);
            
});
        },
        _loadPack: function() {
            var self = this, url = "lang/" + self.storageLang + "/validationengine.lang.js";
            $.getScript(url, function(data) {
                self._cacheLangPacks(), self._renderForm();
            });
        },
        _returnAllRules: function() {
            var self = this, returnAllRules = function() {
                $.validationEngineLanguage.allRules = self.langPacks[self.storageLang];
            };
            return returnAllRules();
        },
        _cacheLangPacks: function() {
            var self = this, lang = $.validationEngineLanguage, langName, langObj;
            for (var attr in lang) langName = attr, langObj = lang[attr];
            self.langPacks[langName] = langObj;
        }
    };
    return validator;
}), define("text!partials/director_1.html", [], function() {
    return '<div class="container-fluid">\r\n    <div class="row portal-line-height">\r\n        <div class="col-xs-5 col-sm-8 col-md-8 col-lg-9">\r\n        </div>\r\n        <div class="col-xs-3 col-sm-2 col-md-2 col-lg-1">\r\n        </div>\r\n        <div class="col-xs-4 col-sm-2 col-md-2 col-lg-2">\r\n            <div class="my-float">\r\n                <span class="my-font-style" id="return-to-homepage" data-lang="{text:return_to_home}"></span>\r\n            </div>\r\n        </div>\r\n    </div>\r\n    <form id="inner-view-container" class="form-horizontal container-fluid my-pre-step-next-step-height" role="form">\r\n        <div class="row portal-height">\r\n           <h4 style="font-weight: 700;font-size: 14px;padding-right: 26px" class="col-sm-3 text-right minify-style" data-lang="{text:connect_internet}"></h4>\r\n        </div>\r\n        <div class="row">\r\n            <div class="form-group">\r\n                <label class="col-sm-3 control-label" data-lang="{text:interface_type}"></label>\r\n                <div class="col-sm-3">\r\n                    <select id="wan_port" class="form-control">\r\n                        <option value=1>3G/LTE</option>\r\n                        <option value=2>ADSL</option>\r\n                        <option value=3>DHCP</option>\r\n                        <option value=4>Static IP Address</option>\r\n                    </select>\r\n                </div>\r\n            </div>\r\n            <div class="col-xs-6 col-sm-6 col-md-6 col-lg-7">\r\n            </div>\r\n        </div>\r\n        <div class="row cell-row">\r\n            <div class="form-group">\r\n                <label class="col-sm-3 control-label" data-lang="{text:apn}"></label>\r\n                <div class="col-sm-3">\r\n                    <input type="text" id="cellular-apn" class="form-control validate[required]"  />\r\n                </div>\r\n            </div>\r\n            <div class="col-xs-6 col-sm-6 col-md-6 col-lg-7">\r\n            </div>\r\n        </div>\r\n        <div class="row cell-row">\r\n            <div class="form-group">\r\n                <label class="col-sm-3 control-label" data-lang="{text:username}"></label>\r\n                <div class="col-sm-3">\r\n                    <input type="text" id="cellular-username" class="form-control validate[required]" />\r\n                </div>\r\n            </div>\r\n            <div class="col-xs-6 col-sm-6 col-md-6 col-lg-7">\r\n            </div>\r\n        </div>\r\n        <div class="row cell-row">\r\n            <div class="form-group">\r\n                <label class="col-sm-3 control-label" data-lang="{text:password}"></label>\r\n                <div class="col-sm-3">\r\n                    <input type="text" id="cellular-password" class="form-control validate[required]" />\r\n                </div>\r\n            </div>\r\n            <div class="col-xs-6 col-sm-6 col-md-6 col-lg-7">\r\n            </div>\r\n        </div>\r\n        <div class="row cell-row">\r\n            <div class="form-group">\r\n                <label class="col-sm-3 control-label" data-lang="{text:dial_numbers}"></label>\r\n                <div class="col-sm-3">\r\n                    <input type="text" id="cellular-dial-number" class="form-control validate[required]" />\r\n                </div>\r\n            </div>\r\n            <div class="col-xs-6 col-sm-6 col-md-6 col-lg-7">\r\n            </div>\r\n        </div>\r\n        <div class="row adsl-row">\r\n            <div class="form-group">\r\n                <label class="col-sm-3 control-label" data-lang="{text:username}"></label>\r\n                <div class="col-sm-3">\r\n                    <input type="text" id="adsl-username" class="form-control validate[required]" />\r\n                </div>\r\n            </div>\r\n            <div class="col-xs-6 col-sm-6 col-md-6 col-lg-7">\r\n            </div>\r\n        </div>\r\n        <div class="row adsl-row">\r\n            <div class="form-group">\r\n                <label class="col-sm-3 control-label" data-lang="{text:password}"></label>\r\n                <div class="col-sm-3">\r\n                    <input type="text" id="adsl-password" class="form-control validate[required]" />\r\n                </div>\r\n            </div>\r\n            <div class="col-xs-6 col-sm-6 col-md-6 col-lg-7">\r\n            </div>\r\n        </div>\r\n        <div class="row static-ip-address-row">\r\n            <div class="form-group">\r\n                <label class="col-sm-3 control-label" data-lang="{text:main_ip}"></label>\r\n                <div class="col-sm-3">\r\n                    <input type="text" id="static-ip-address-main-ip" class="form-control validate[required,custom[ip]]" />\r\n                </div>\r\n            </div>\r\n            <div class="col-xs-6 col-sm-6 col-md-6 col-lg-7">\r\n            </div>\r\n        </div>\r\n        <div class="row static-ip-address-row">\r\n            <div class="form-group">\r\n                <label class="col-sm-3 control-label" data-lang="{text:subnet_mask}"></label>\r\n                <div class="col-sm-3">\r\n                    <input type="text" id="static-ip-address-subnet-mask" class="form-control validate[required,custom[ip]]" />\r\n                </div>\r\n            </div>\r\n            <div class="col-xs-6 col-sm-6 col-md-6 col-lg-7">\r\n            </div>\r\n        </div>\r\n        <div class="row static-ip-address-row">\r\n            <div class="form-group">\r\n                <label class="col-sm-3 control-label" data-lang="{text:gateway}"></label>\r\n                <div class="col-sm-3">\r\n                    <input type="text" id="static-ip-address-gateway" class="form-control validate[required,custom[ip]]" />\r\n                </div>\r\n            </div>\r\n            <div class="col-xs-6 col-sm-6 col-md-6 col-lg-7">\r\n            </div>\r\n        </div>\r\n        <div class="row static-ip-address-row">\r\n            <div class="form-group">\r\n                <label class="col-sm-3 control-label" data-lang="{text:preferred_domain}"></label>\r\n                <div class="col-sm-3">\r\n                    <input type="text" id="static-ip-address-preferred-domain" class="form-control validate[required,custom[ip]]]" />\r\n                </div>\r\n            </div>\r\n            <div class="col-xs-6 col-sm-6 col-md-6 col-lg-7">\r\n            </div>\r\n        </div>\r\n        <div class="row static-ip-address-row">\r\n            <div class="form-group">\r\n                <label class="col-sm-3 control-label" data-lang="{text:alternate_domain}"></label>\r\n                <div class="col-sm-3">\r\n                    <input type="text" id="static-ip-address-alternate-domain" class="form-control validate[custom[ip]]" />\r\n                </div>\r\n            </div>\r\n            <div class="col-xs-6 col-sm-6 col-md-6 col-lg-7">\r\n            </div>\r\n        </div>\r\n        <div class="my-pre-step-next-step-position">\r\n            <button type="button" class="btn btn-default btn-sm adjust-en-ch" id="pre-step" data-lang="{text:pre_step}"></button>\r\n            <button type="button" class="btn btn-default btn-sm adjust-en-ch" id="next-step" data-lang="{text:next_step}"></button>\r\n        </div>\r\n    </form>\r\n</div>'
;
}), define("text!partials/director_2.html", [], function() {
    return '<div class="row portal-height">\r\n    <h4 style="font-weight: 700;font-size: 14px;padding-right: 26px" class="minify-style col-sm-3 col-md-4 col-lg-3 text-right" data-lang="{text:manage_platform}"></h4>\r\n</div>\r\n<div class="row">\r\n    <div class="form-group">\r\n        <label for="rainbow_address" class="col-sm-3 col-md-3 col-lg-3 control-label" data-lang="{text:rainbow_ip}"></label>\r\n        <div class="col-sm-3 col-md-4 col-lg-3 except-minify-padding">\r\n            <input type="text" class="form-control my-input-radius-control validate[custom[rainbowip]]" id="rainbow_address" data-lang="{placeholder:enter_ip_address}" />\r\n        </div>\r\n        <div class="col-sm-2 col-md-1 col-lg-1 input-group addone-margin-left">\r\n            <div class="input-group-addon addone-no-radius">:</div>\r\n            <input type="text" class="form-control addone-input-mobile validate[custom[rainbowport]]" data-lang="{placeholder:port}" id="rainbow_port">\r\n        </div>\r\n    </div>\r\n    <div class="form-group">\r\n        <label for="check-mode"  class="col-sm-3 col-md-3 control-label" data-lang="{text:demo_mode}"></label>\r\n        <div class="col-sm-8">\r\n            <div class="checkbox">\r\n                <!--<label>-->\r\n                   <input type="checkbox" id="check-mode" class="my-margin-left-checkbox">\r\n                <!--</label>-->\r\n            </div>\r\n        </div>\r\n    </div>\r\n</div>\r\n<div class="my-pre-step-next-step-position">\r\n    <button type="button" class="btn btn-default btn-sm adjust-en-ch" id="pre-step" data-lang="{text:pre_step}"></button>\r\n    <button type="button" class="btn btn-default btn-sm adjust-en-ch" id="next-step" data-lang="{text:apply_config}"></button>\r\n</div>'
;
}), define("app/director_2", [ "require", "text!partials/director_2.html", "app/originalApp", "tool/locale", "tool/validator" ], function(require) {
    var html = require("text!partials/director_2.html"), App = require("app/originalApp"), locale = require("tool/locale"), validator = require("tool/validator"), DirectorTwo = Class.create(App, {
        initialize: function($super, options) {
            $super(options), this.preBrotherApp = options.appObj, this.mainApp = options.mainApp, this.render();
        },
        render: function() {
            var self = this;
            self.viewContainer.html(html), self.bindEvents(), self.getTemplate(), self.getRainbowConfig(), validator.render("#inner-view-container", {
                promptPosition: "topLeft",
                scroll: !1
            }), locale.render();
        },
        getTemplate: function() {
            var self = this;
            self.ajax({
                type: "GET",
                url: "json/cliCommand.json"
,
                success: function(data, textStatus) {
                    typeof data == "string" && (data = JSON.parse(data)), self.rainbowPostTemplate = data.rainbowconfig.cli_cmd_post;
                },
                error: function(xhr, err) {}
            });
        },
        getRainbowConfig: function() {
            var self = this;
            self.ajax({
                type: "GET",
                url: "js/app/director_2.jsx",
                success: function(data, textstatus) {
                    var rainbowConfig = rainbow_config;
                    self.setFormData(rainbowConfig);
                },
                error: function(xhr, err) {}
            });
        },
        setFormData: function(obj) {
            var self = this;
            $("#rainbow_address").val(obj.server), $("#rainbow_port").val(obj.port), obj.enable && $("#check-mode").prop({
                checked: !0
            });
        },
        bindEvents: function() {
            var self = 
this;
            self.viewContainer.find("#pre-step").bind("click", function(e) {
                self.destroySelfAll(), self.fire("afterClick");
            }).end().find("#next-step").bind("click", function(e) {
                var callback = function(data) {
                    this.ajax({
                        url: "../apply.cgi",
                        type: "POST",
                        data: data,
                        processData: !1,
                        contentType: "text/plain;charset=utf-8",
                        success: function(data, textStatus) {
                            $("#return-to-homepage").trigger("click");
                        },
                        error: function(xhr, err) {},
                        showBlock: !0
                    });
                };
                validator.result("#inner-view-container") && self.mergeAndSendFormData(callback);
            }).end().find("#rainbow_port").bind("change", function(e) {
                
var temp = $(this).val(), regex = /^\d+$/;
                regex.test(temp) && (temp = parseInt(temp), $(this).val(temp));
            });
        },
        mergeAndSendFormData: function(callback) {
            var self = this, data = {};
            data.server = $("#rainbow_address").val(), data.port = $("#rainbow_port").val(), $("#check-mode").prop("checked") ? data.mode = 1 : data.mode = 0;
            var template = new Template(self.rainbowPostTemplate), result = template.evaluate(data), str = "_ajax=1&_web_cmd=" + encodeURIComponent(result);
            callback.call(self, str);
        },
        destroySelfAll: function() {
            var self = this;
            self.viewContainer.find("#pre-step").unbind().end().find("#next-step").unbind(), self.destroy();
        },
        rebuild: function() {
            var self = this;
            self.render();
        }
    });
    return DirectorTwo;
}), define("app/director_1", [ "require", "text!partials/director_1.html", "app/originalApp"
, "app/director_2", "tool/locale", "tool/validator" ], function(require) {
    var html = require("text!partials/director_1.html"), App = require("app/originalApp"), DirectorTwo = require("app/director_2"), locale = require("tool/locale"), validator = require("tool/validator"), DirectorOne = Class.create(App, {
        initialize: function($super, options) {
            $super(options), this.wanRowClassArray = [ "", "cell-row", "adsl-row", "dhcp-row", "static-ip-address-row" ], this.mainApp = options.mainApp, this.render();
        },
        render: function() {
            var self = this;
            self.viewContainer.html(html), self.bindEvents(), self.getTemplate(), self.getCurrentConfig(), validator.render("#inner-view-container", {
                promptPosition: "topRight",
                scroll: !1
            }), locale.render();
        },
        setFormData: function(obj) {
            var self = this, cellular = obj.cellularConfig, adsl = obj.adslConfig, dhcp = obj.staticIpConfig
;
            $("#cellular-apn").val(cellular.apn), $("#cellular-dial-number").val(cellular.dialNumber), $("#cellular-username").val(cellular.username), $("#cellular-password").val(cellular.password), adsl && ($("#adsl-username").val(adsl.username), $("#adsl-password").val(adsl.password)), $("#static-ip-address-main-ip").val(dhcp.staticIp), dhcp.subnetMask ? $("#static-ip-address-subnet-mask").val(dhcp.subnetMask) : $("#static-ip-address-subnet-mask").val("255.255.255.0"), $("#static-ip-address-gateway").val(dhcp.gateway), $("#static-ip-address-preferred-domain").val(dhcp.dns_1), $("#static-ip-address-alternate-domain").val(dhcp.dns_2), self.setSelect();
        },
        setSelect: function() {
            var self = this;
            switch (self.wanPort) {
              case "cellular 1":
                $("select#wan_port").val(1).trigger("change");
                break;
              case "dialer 10":
                $("select#wan_port").val(2).trigger("change");
                
break;
              case "vlan 10":
                self.distinguish == 1 ? $("select#wan_port").val(3).trigger("change") : self.distinguish == 0 && $("select#wan_port").val(4).trigger("change");
                break;
              default:
            }
        },
        getCurrentConfig: function() {
            var self = this, date1 = new Date;
            console.log("\u5f00\u59cb"), self.ajax({
                type: "get",
                url: "js/app/director_1.jsx",
                success: function(data, textStatus) {
                    var date2 = new Date;
                    console.log("\u8bf7\u6c42\u6210\u529f\uff0c\u7ecf\u8fc7" + (date2.getTime() - date1.getTime()) / 1e3 + "s"), static_route_config.each(function(one) {
                        one[0] == "0.0.0.0" && one[1] == "0.0.0.0" && (self.wanPort = one[2], self.gateway = one[3]);
                    });
                    var cellularConfig = {}, arr_1 = cellular1_config.profiles[0];
                    cellularConfig
.apn = arr_1[2], cellularConfig.dialNumber = arr_1[3], cellularConfig.username = arr_1[5], cellularConfig.password = arr_1[6];
                    if (dialer_config.length != 0) {
                        var adslConfig = {}, arr_2 = dialer_config[0];
                        adslConfig.username = arr_2[4], adslConfig.password = arr_2[5];
                    }
                    var dhcpConfig = {}, staticIpConfig = {}, arr_3 = svi_interface.find(function(one) {
                        return one[0] == "vlan 10";
                    });
                    arr_3 && (self.distinguish = arr_3[6], staticIpConfig.staticIp = arr_3[3], staticIpConfig.subnetMask = arr_3[4]), staticIpConfig.gateway = self.gateway, staticIpConfig.dns_1 = dns_server.dns_1, staticIpConfig.dns_2 = dns_server.dns_2;
                    var obj = {};
                    obj.cellularConfig = cellularConfig, obj.adslConfig = adslConfig, obj.staticIpConfig = staticIpConfig, self.setFormData(obj);
                    var date3 = new 
Date;
                    console.log("\u6e32\u67d3\u5b8c\u6bd5" + (date3.getTime() - date1.getTime()) / 1e3 + "s");
                }
            });
        },
        getTemplate: function() {
            var self = this;
            self.ajax({
                type: "get",
                url: "json/cliCommand.json",
                contentType: "application/json",
                success: function(data, textStatus) {
                    typeof data == "string" && (data = JSON.parse(data)), self.cellularPostTemplate = data.cellular.cli_cmd_post, self.adslPostTemplate = data.adsl.cli_cmd_post, self.dhcpPostTemplate = data.dhcp.cli_cmd_post, self.staticIpPostTemplate = data.staticip.cli_cmd_post;
                }
            });
        },
        mergeAndSendFormData: function(callback) {
            var self = this, index = $("select#wan_port").val();
            index = parseInt(index);
            switch (index) {
              case 1:
                var obj = {};
                
obj.number = 1, obj.apn = $("#cellular-apn").val(), obj.dialNumber = $("#cellular-dial-number").val(), obj.username = $("#cellular-username").val(), obj.password = $("#cellular-password").val();
                var template = new Template(self.cellularPostTemplate), result = template.evaluate(obj), str = "_ajax=1&_web_cmd=" + encodeURIComponent(result);
                callback.call(self, str);
                break;
              case 2:
                var obj = {};
                obj.username = $("#adsl-username").val(), obj.password = $("#adsl-password").val();
                var template = new Template(self.adslPostTemplate), result = template.evaluate(obj), str = "_ajax=1&_web_cmd=" + encodeURIComponent(result);
                callback.call(self, str);
                break;
              case 3:
                var result = self.dhcpPostTemplate, str = "_ajax=1&_web_cmd=" + encodeURIComponent(result);
                callback.call(self, str);
                break;
              
case 4:
                var obj = {};
                obj.staticIp = $("#static-ip-address-main-ip").val(), obj.subnetMask = $("#static-ip-address-subnet-mask").val(), obj.gateway = $("#static-ip-address-gateway").val(), obj.dns_1 = $("#static-ip-address-preferred-domain").val(), obj.dns_2 = $("#static-ip-address-alternate-domain").val(), obj.dns_2 && (self.staticIpPostTemplate = self.staticIpPostTemplate.replace(/8\.8\.8\.8/g, obj.dns_2));
                var template = new Template(self.staticIpPostTemplate), result = template.evaluate(obj), str = "_ajax=1&_web_cmd=" + encodeURIComponent(result);
                callback.call(self, str);
                break;
              default:
            }
        },
        bindEvents: function() {
            var self = this;
            self.allCellRows = self.viewContainer.find("div.cell-row"), self.allAdslRows = self.viewContainer.find("div.adsl-row").hide(), self.allDhcpRows = self.viewContainer.find("div.dhcp-row").hide(), self.allStaticIpRows = 
self.viewContainer.find("div.static-ip-address-row").hide(), self.rowsElementArray = [ "", self.allCellRows, self.allAdslRows, self.allDhcpRows, self.allStaticIpRows ], self.viewContainer.find("#return-to-homepage").bind("click", function(e) {
                self.destroySelfAll(), self.fire("afterClick");
            }).end().find("#pre-step").bind("click", function(e) {
                self.destroySelfAll(), self.fire("afterClick");
            }).end().find("#next-step").bind("click", function(e) {
                var callback = function(data) {
                    self.destroySelfAppButContainer(), self.directorTwo = new DirectorTwo({
                        elementId: "inner-view-container",
                        events: {
                            afterClick: function() {
                                this.rebuild();
                            },
                            scope: self
                        }
                    }), this.ajax({
                        url
: "../apply.cgi",
                        type: "POST",
                        data: data,
                        processData: !1,
                        contentType: "text/plain;charset=utf-8",
                        success: function(data, textStatus) {},
                        error: function(xhr, err) {}
                    });
                };
                validator.result("#inner-view-container") && self.mergeAndSendFormData(callback);
            }).end().find("select#wan_port").bind("change", function(e) {
                var value = $(this).val();
                value = parseInt(value), self.selectValue = value, validator.hideAll();
                switch (value) {
                  case 1:
                    self.renderWanRow(1);
                    break;
                  case 2:
                    self.renderWanRow(2);
                    break;
                  case 3:
                    self.renderWanRow(3);
                    break;
                  case 4
:
                    self.renderWanRow(4);
                    break;
                  default:
                }
            });
        },
        renderWanRow: function(index) {
            var self = this;
            switch (index) {
              case 1:
                self.hideAndShow(1);
                break;
              case 2:
                self.hideAndShow(2);
                break;
              case 3:
                self.hideAndShow(3);
                break;
              case 4:
                self.hideAndShow(4);
                break;
              default:
            }
        },
        hideAndShow: function(index) {
            var self = this;
            switch (index) {
              case 1:
                self._hideAndShow(1);
                break;
              case 2:
                self._hideAndShow(2);
                break;
              case 3:
                self._hideAndShow(3);
                break;
              case 4:
                
self._hideAndShow(4);
                break;
              default:
            }
        },
        _hideAndShow: function(index) {
            var self = this;
            self.rowsElementArray.each(function(one, i) {
                index == i ? one.show() : i != 0 && one.hide();
            });
        },
        destroySelfAppButContainer: function() {
            var self = this;
            self.viewContainer.find("#inner-view-container").empty();
        },
        destroySelfAll: function() {
            var self = this;
            self.viewContainer.find("#return-to-homepage").unbind().end().find("#pre-step").unbind().end().find("#next-step").unbind(), self.destroy();
        },
        rebuild: function() {
            var self = this;
            self.render();
        }
    });
    return DirectorOne;
}), define("app/mainApp", [ "require", "text!partials/mainApp.html", "app/originalApp", "text!../../css/mainApp.css", "tool/locale", "tool/validator", "app/director_1" ], function(
require) {
    var html = require("text!partials/mainApp.html"), App = require("app/originalApp");
    require("text!../../css/mainApp.css");
    var locale = require("tool/locale"), validator = require("tool/validator"), DirectorOne = require("app/director_1");
    function timeFormate(seconds) {
        if (seconds > 0 && seconds < 60) return seconds + locale.get("seconds");
        if (seconds >= 60 && seconds < 3600) {
            var leftSeconds = seconds % 60, minutes = (seconds - leftSeconds) / 60;
            return minutes + locale.get("minutes") + leftSeconds + locale.get("seconds");
        }
        if (seconds >= 3600 && seconds < 86400) {
            var leftSeconds = seconds % 3600, hours = (seconds - leftSeconds) / 3600, tempLeftSeconds = leftSeconds % 60, minutes = (leftSeconds - tempLeftSeconds) / 60;
            return hours + locale.get("hours") + minutes + locale.get("minutes") + tempLeftSeconds + locale.get("seconds");
        }
        if (seconds >= 86400) {
            
var leftSeconds = seconds % 86400, days = (seconds - leftSeconds) / 86400, tempLeftSeconds = leftSeconds % 3600, hours = (leftSeconds - tempLeftSeconds) / 3600, finaLeftSeconds = tempLeftSeconds % 60, minutes = (tempLeftSeconds - finaLeftSeconds) / 60;
            return days + locale.get("days") + hours + locale.get("hours") + minutes + locale.get("minutes") + finaLeftSeconds + locale.get("seconds");
        }
    }
    var MainApp = Class.create(App, {
        initialize: function($super, options) {
            $super(options), this.render();
        },
        render: function() {
            var self = this;
            self.viewContainer.html(html), self.bindEvents(), locale.render(), self.getUserData();
        },
        bindEvents: function() {
            var self = this;
            self.viewContainer.find("#config-director").bind("click", function(e) {
                self.destroys(), self.directorOne = null, self.directorOne = new DirectorOne({
                    elementId: "page-view"
,
                    events: {
                        afterClick: function() {
                            self.rebuild();
                        },
                        scope: self
                    }
                });
            });
        },
        rebuild: function() {
            var self = this;
            self.render();
        },
        getUserData: function() {
            var self = this;
            self.ajax({
                url: "js/app/mainApp.jsx",
                type: "get",
                success: function(data, textStatus) {
                    eval(data), console.log(data), $("#nav-row").find("#user-name").text("admin"), static_route_config.each(function(one) {
                        one[0] == "0.0.0.0" && one[1] == "0.0.0.0" && (self.wanPort = one[2]);
                    });
                    var data = self.formatData();
                    self.viewContainer.find("#network-state").text(data.statusComment + "\uff0c" + data.wanPort).end().find("#network-period"
).text(data.connectTime).end();
                }
            });
        },
        formatData: function() {
            var self = this, network = new Object;
            if (self.wanPort.indexOf("cellular") != -1) {
                network.wanPort = "3G/LTE";
                var cellular_arr = cellular_interface.find(function(one) {
                    return one[0] == "cellular 1";
                }), posSt = cellular_arr[2];
                posSt == 1 ? network.statusComment = locale.get("connected") : posSt == 0 && (network.statusComment = locale.get("disconnected"));
                var posTime = cellular_arr[8];
                posTime == 0 ? network.connectTime = locale.get("disconnected") : posTime > 0 && (network.connectTime = timeFormate(posTime));
            } else if (self.wanPort.indexOf("dialer") != -1) {
                network.wanPort = "ADSL";
                var arr_adsl = xdsl_interface.find(function(one) {
                    return one[0].indexOf("dialer") != -1;
                
}), posSt = arr_adsl[2];
                posSt == "1" ? network.statusComment = locale.get("connected") : posSt == "0" && (network.statusComment = locale.get("disconnected"));
                var posTime = arr_adsl[8];
                posTime == 0 ? network.connectTime = locale.get("disconnected") : posTime > 0 && (network.connectTime = timeFormate(posTime));
            } else if (self.wanPort.indexOf("vlan") != -1) {
                var arr_vlan = svi_interface.find(function(one) {
                    return one[0] == "vlan 10";
                });
                if (arr_vlan) {
                    arr_vlan[6] == "1" ? network.wanPort = "DHCP" : arr_vlan[6] == "0" && (network.wanPort = "Static IP");
                    var posSt = arr_vlan[2];
                    posSt == "1" ? network.statusComment = locale.get("connected") : posSt == "0" && (network.statusComment = locale.get("disconnected"));
                    var posTime = arr_vlan[9];
                    posTime == 0 ? network
.connectTime = locale.get("disconnected") : posTime > 0 && (network.connectTime = timeFormate(posTime));
                }
            }
            return network;
        },
        getSummaryConfig: function() {
            var self = this;
            self.ajax({
                url: "json/summary.json",
                type: "get",
                contentType: "application/json",
                success: function(data, textStatus) {
                    typeof data == "string" && (data = JSON.parse(data)), self.viewContainer.find("#network-state").text(data.network.state).end().find("#network-period").text(data.network.period).end().find("#network-flow").text(data.network.flow).end().find("#wifi-ssid").text(data.wifi.ssid).end().find("#wifi-devices").text(data.wifi.devices).end().find("#wifi-users").text(data.wifi.users).end().find("#sync-html").text(data.sync.html).end().find("#sync-scripts").text(data.sync.scripts).end().find("#sync-conf").text(data.sync.conf);
                }
            
});
        },
        destroys: function() {
            var self = this;
            self.destroy(), self.viewContainer.find("#config-director").unbind();
        }
    });
    return MainApp;
}), require.config({
    baseUrl: "js",
    paths: {
        jquery: "lib/jquery-1.11.1.min",
        prototype: "lib/prototype",
        lang: "../lang",
        text: "lib/text"
    },
    shim: {
        "lib/jquery.validationEngine": [ "jquery" ],
        "lib/jquery.blockUI": [ "jquery" ],
        "tool/locale": [ "jquery" ],
        "tool/validator": [ "jquery" ]
    }
}), require([ "jquery", "prototype", "app/mainApp" ], function($, prototype, mainApp) {
    $(document).ready(function($) {
        var language = navigator.language ? navigator.language : navigator.userLanguage;
        language.toLowerCase() == "zh-cn" ? localStorage.setItem("language", "zh_CN") : localStorage.setItem("language", "en");
        var app = new mainApp({
            elementId: "page-view"
        });
        
$("img.my-title-img").prop("src", "images/Logo-InHand.png");
    });
}), define("main", function() {});;