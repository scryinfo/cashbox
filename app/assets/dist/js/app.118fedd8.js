(function(t){function e(e){for(var r,a,i=e[0],c=e[1],u=e[2],p=0,f=[];p<i.length;p++)a=i[p],Object.prototype.hasOwnProperty.call(o,a)&&o[a]&&f.push(o[a][0]),o[a]=0;for(r in c)Object.prototype.hasOwnProperty.call(c,r)&&(t[r]=c[r]);s&&s(e);while(f.length)f.shift()();return l.push.apply(l,u||[]),n()}function n(){for(var t,e=0;e<l.length;e++){for(var n=l[e],r=!0,i=1;i<n.length;i++){var c=n[i];0!==o[c]&&(r=!1)}r&&(l.splice(e--,1),t=a(a.s=n[0]))}return t}var r={},o={app:0},l=[];function a(e){if(r[e])return r[e].exports;var n=r[e]={i:e,l:!1,exports:{}};return t[e].call(n.exports,n,n.exports,a),n.l=!0,n.exports}a.m=t,a.c=r,a.d=function(t,e,n){a.o(t,e)||Object.defineProperty(t,e,{enumerable:!0,get:n})},a.r=function(t){"undefined"!==typeof Symbol&&Symbol.toStringTag&&Object.defineProperty(t,Symbol.toStringTag,{value:"Module"}),Object.defineProperty(t,"__esModule",{value:!0})},a.t=function(t,e){if(1&e&&(t=a(t)),8&e)return t;if(4&e&&"object"===typeof t&&t&&t.__esModule)return t;var n=Object.create(null);if(a.r(n),Object.defineProperty(n,"default",{enumerable:!0,value:t}),2&e&&"string"!=typeof t)for(var r in t)a.d(n,r,function(e){return t[e]}.bind(null,r));return n},a.n=function(t){var e=t&&t.__esModule?function(){return t["default"]}:function(){return t};return a.d(e,"a",e),e},a.o=function(t,e){return Object.prototype.hasOwnProperty.call(t,e)},a.p="/";var i=window["webpackJsonp"]=window["webpackJsonp"]||[],c=i.push.bind(i);i.push=e,i=i.slice();for(var u=0;u<i.length;u++)e(i[u]);var s=c;l.push([0,"chunk-vendors"]),n()})({0:function(t,e,n){t.exports=n("56d7")},"034f":function(t,e,n){"use strict";var r=n("64a9"),o=n.n(r);o.a},"56d7":function(t,e,n){"use strict";n.r(e);n("cadf"),n("551c"),n("f751"),n("097d");var r=n("2b0e"),o=function(){var t=this,e=t.$createElement,r=t._self._c||e;return r("div",{attrs:{id:"app"}},[r("img",{attrs:{alt:"Vue logo",src:n("cf05")}}),r("HelloWorld",{attrs:{msg:"Welcome to Your Vue.js App"}})],1)},l=[],a=function(){var t=this,e=t.$createElement,n=t._self._c||e;return n("div",{staticClass:"hello"},[n("button",{on:{click:t.callNativePwdDialog}},[t._v("测试调用密码弹框")]),n("br"),n("br"),n("br"),n("button",{on:{click:t.callNativeQrScan}},[t._v("测试调用二维码扫描功能")]),n("br"),n("br"),n("br"),n("input",{directives:[{name:"model",rawName:"v-model",value:t.qrResult,expression:"qrResult"}],staticClass:"title-input",attrs:{name:"title"},domProps:{value:t.qrResult},on:{input:function(e){e.target.composing||(t.qrResult=e.target.value)}}}),n("br"),n("br"),n("br")])},i=[],c={name:"HelloWorld",data:function(){return{qrResult:""}},created:function(){window["callJs"]=this.callJs},mounted:function(){console.log("everyting is ok begin to call=======================>")},methods:{callNativePwdDialog:function(){console.log("js begin to callNativePwdDialog==========>"),NativePwdDialog.postMessage(this.qrResult),this.qrResult=window.qrResult},callNativeQrScan:function(){NativeQrScan.postMessage("这是从js回来调qrscan"),console.log("js begin to NativeQrScan==========>")},callJs:function(t){console.log("callJs======================>"+t),this.qrResult=t}}},u=c,s=n("2877"),p=Object(s["a"])(u,a,i,!1,null,"77138648",null),f=p.exports,d={name:"app",components:{HelloWorld:f}},v=d,b=(n("034f"),Object(s["a"])(v,o,l,!1,null,null,null)),g=b.exports;r["a"].config.productionTip=!1,new r["a"]({render:function(t){return t(g)}}).$mount("#app")},"64a9":function(t,e,n){},cf05:function(t,e,n){t.exports=n.p+"img/logo.82b9c7a5.png"}});
//# sourceMappingURL=app.118fedd8.js.map