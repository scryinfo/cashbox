(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-17145e97"],{"0147":function(t,e,i){i("a29f"),i("0607"),i("949e"),i("7565"),i("dfda")},"01fb":function(t,e,i){},"0662":function(t,e,i){i("a29f"),i("adba")},"0958":function(t,e,i){},2477:function(t,e,i){i("a29f"),i("ae60")},"339f":function(t,e,i){i("a29f"),i("875a")},"681e":function(t,e,i){i("a29f"),i("01fb")},7597:function(t,e,i){i("a29f"),i("0607"),i("949e"),i("857f")},"78eb":function(t,e,i){"use strict";i.d(e,"a",(function(){return n}));var n={inject:{vanField:{default:null}},watch:{value:function(){var t=this.vanField;t&&(t.resetValidation(),t.validateWithTrigger("onChange"))}},created:function(){var t=this.vanField;t&&!t.children&&(t.children=this)}}},"857f":function(t,e,i){},"875a":function(t,e,i){},"9f14":function(t,e,i){"use strict";var n=i("d282"),s=i("ad06"),a=i("78eb"),o=i("9884"),r=i("ea8e"),d=function(t){var e=t.parent,i=t.bem,n=t.role;return{mixins:[Object(o["a"])(e),a["a"]],props:{name:null,value:null,disabled:Boolean,iconSize:[Number,String],checkedColor:String,labelPosition:String,labelDisabled:Boolean,shape:{type:String,default:"round"},bindGroup:{type:Boolean,default:!0}},computed:{disableBindRelation:function(){return!this.bindGroup},isDisabled:function(){return this.parent&&this.parent.disabled||this.disabled},direction:function(){return this.parent&&this.parent.direction||null},iconStyle:function(){var t=this.checkedColor||this.parent&&this.parent.checkedColor;if(t&&this.checked&&!this.isDisabled)return{borderColor:t,backgroundColor:t}},tabindex:function(){return this.isDisabled||"radio"===n&&!this.checked?-1:0}},methods:{onClick:function(t){var e=this,i=t.target,n=this.$refs.icon,s=n===i||n.contains(i);this.isDisabled||!s&&this.labelDisabled?this.$emit("click",t):(this.toggle(),setTimeout((function(){e.$emit("click",t)})))},genIcon:function(){var t=this.$createElement,e=this.checked,n=this.iconSize||this.parent&&this.parent.iconSize;return t("div",{ref:"icon",class:i("icon",[this.shape,{disabled:this.isDisabled,checked:e}]),style:{fontSize:Object(r["a"])(n)}},[this.slots("icon",{checked:e})||t(s["a"],{attrs:{name:"success"},style:this.iconStyle})])},genLabel:function(){var t=this.$createElement,e=this.slots();if(e)return t("span",{class:i("label",[this.labelPosition,{disabled:this.isDisabled}])},[e])}},render:function(){var t=arguments[0],e=[this.genIcon()];return"left"===this.labelPosition?e.unshift(this.genLabel()):e.push(this.genLabel()),t("div",{attrs:{role:n,tabindex:this.tabindex,"aria-checked":String(this.checked)},class:i([{disabled:this.isDisabled,"label-disabled":this.labelDisabled},this.direction]),on:{click:this.onClick}},[e])}}},l=Object(n["a"])("radio"),c=l[0],u=l[1];e["a"]=c({mixins:[d({bem:u,role:"radio",parent:"vanRadio"})],computed:{currentValue:{get:function(){return this.parent?this.parent.value:this.value},set:function(t){(this.parent||this).$emit("input",t)}},checked:function(){return this.currentValue===this.name}},methods:{toggle:function(){this.currentValue=this.name}}})},a19f:function(t,e,i){"use strict";i("efee")},adba:function(t,e,i){},ae60:function(t,e,i){},b4eb:function(t,e,i){i("a29f"),i("8a5a"),i("0607"),i("949e"),i("247c"),i("f251"),i("0958")},b650:function(t,e,i){"use strict";var n=i("c31d"),s=i("2638"),a=i.n(s),o=i("d282"),r=i("ba31"),d=i("b1d2"),l=i("48f4"),c=i("ad06"),u=i("543e"),h=Object(o["a"])("button"),p=h[0],f=h[1];function b(t,e,i,n){var s,o=e.tag,h=e.icon,p=e.type,b=e.color,g=e.plain,m=e.disabled,v=e.loading,A=e.hairline,O=e.loadingText,_=e.iconPosition,C={};function S(t){v||m||(Object(r["a"])(n,"click",t),Object(l["a"])(n))}function k(t){Object(r["a"])(n,"touchstart",t)}b&&(C.color=g?b:d["f"],g||(C.background=b),-1!==b.indexOf("gradient")?C.border=0:C.borderColor=b);var y=[f([p,e.size,{plain:g,loading:v,disabled:m,hairline:A,block:e.block,round:e.round,square:e.square}]),(s={},s[d["b"]]=A,s)];function w(){return v?i.loading?i.loading():t(u["a"],{class:f("loading"),attrs:{size:e.loadingSize,type:e.loadingType,color:"currentColor"}}):h?t(c["a"],{attrs:{name:h,classPrefix:e.iconPrefix},class:f("icon")}):void 0}function x(){var n,s=[];return"left"===_&&s.push(w()),n=v?O:i.default?i.default():e.text,n&&s.push(t("span",{class:f("text")},[n])),"right"===_&&s.push(w()),s}return t(o,a()([{style:C,class:y,attrs:{type:e.nativeType,disabled:m},on:{click:S,touchstart:k}},Object(r["b"])(n)]),[t("div",{class:f("content")},[x()])])}b.props=Object(n["a"])({},l["c"],{text:String,icon:String,color:String,block:Boolean,plain:Boolean,round:Boolean,square:Boolean,loading:Boolean,hairline:Boolean,disabled:Boolean,iconPrefix:String,nativeType:String,loadingText:String,loadingType:String,tag:{type:String,default:"button"},type:{type:String,default:"default"},size:{type:String,default:"normal"},loadingSize:{type:String,default:"20px"},iconPosition:{type:String,default:"left"}}),e["a"]=p(b)},c975:function(t,e,i){"use strict";var n=i("23e7"),s=i("4d64").indexOf,a=i("a640"),o=i("ae40"),r=[].indexOf,d=!!r&&1/[1].indexOf(1,-0)<0,l=a("indexOf"),c=o("indexOf",{ACCESSORS:!0,1:0});n({target:"Array",proto:!0,forced:d||!l||!c},{indexOf:function(t){return d?r.apply(this,arguments)||0:s(this,t,arguments.length>1?arguments[1]:void 0)}})},da53:function(t,e,i){"use strict";i.r(e);var n=function(){var t=this,e=t.$createElement,i=t._self._c||e;return i("div",{staticClass:"authorize_input_page",style:{height:t.bodyHeight+"px"}},[i("div",{staticClass:"top_title_group"},[i("van-icon",{staticClass:"arrow_left",attrs:{slot:"left",name:"arrow-left"},on:{click:t.onClickBack},slot:"left"}),i("span",{staticClass:"middle_text_content"},[t._v(t._s(t.middleTitleText))]),t.isShowRecord?i("span",{staticClass:"right_title_text",attrs:{name:"wap-nav"},on:{click:t.onClickRight}},[t._v(t._s(t.rightTitleText))]):t._e(),i("van-divider",{staticClass:"divider_line"})],1),i("div",{staticClass:"operation_choice_title_group"},[i("span",{staticClass:"operation_choice_title_content"},[t._v(t._s(t.$t("operationTypeSelect")))])]),i("div",{staticClass:"choice_group"},[i("van-radio-group",{staticClass:"choice_radio_group",model:{value:t.radioAuthBtnValue,callback:function(e){t.radioAuthBtnValue=e},expression:"radioAuthBtnValue"}},[i("van-radio",{staticClass:"auth_original",attrs:{name:t.AddAdmin,disabled:t.isDisableAddAdminRadio}},[t._v(" "+t._s(t.$t("addAdmin"))+" ")]),i("van-radio",{staticClass:"auth_cancel",attrs:{name:t.DeleteAdmin}},[t._v(t._s(t.$t("deleteAdmin")))])],1)],1),i("div",{staticClass:"address_choice_title_group"},[i("span",{staticClass:"address_choice_title_content"},[t._v(t._s(t.$t("chooseAdmin")))])]),i("div",{staticClass:"add_name_group"},[i("div",{staticClass:"address_group"},[i("van-cell-group",[i("van-field",{ref:"inputAddressValue",attrs:{label:t.$t("address"),disabled:t.isDisableInputAddress,"right-icon":t.addressRightIcon,placeholder:t.addressHintInfo,required:""},on:{"click-right-icon":t.clickAddressInput},model:{value:t.inputAddressValue,callback:function(e){t.inputAddressValue=e},expression:"inputAddressValue"}})],1)],1),i("div",{staticClass:"username_group"},[i("van-cell-group",[i("van-field",{ref:"inputName",attrs:{label:t.$t("username"),clearable:"",placeholder:t.$t("inputName"),disabled:t.isDisableInputName,required:""},model:{value:t.inputName,callback:function(e){t.inputName=e},expression:"inputName"}})],1)],1)]),i("div",{staticClass:"address_popup_group"},[i("van-popup",{staticClass:"popup_window_group",model:{value:t.isShowAddressPopup,callback:function(e){t.isShowAddressPopup=e},expression:"isShowAddressPopup"}},[i("van-picker",{staticClass:"addPicker",attrs:{"show-toolbar":"",columns:t.addressList,"default-index":t.addressList.length/2},on:{cancel:function(e){t.isShowAddressPopup=!1},confirm:t.confirmPickerAddress}})],1)],1),i("div",{staticClass:"choice_direction_group"},[i("div",{staticClass:"next_step_group",on:{click:t.nextStep}},[i("span",{staticClass:"next_text_class"},[t._v(t._s(t.$t("nextStep")))]),i("van-icon",{staticClass:"right_icon_class",attrs:{name:"arrow"}})],1)]),i("van-overlay",{attrs:{show:t.isLoadingAccount}},[i("van-loading",{staticClass:"loading_component",attrs:{type:"spinner",vertical:""}},[t._v(t._s(t.$t("dataLoading")))])],1)],1)},s=[],a=(i("c975"),i("b0c0"),i("d3b7"),i("ac1f"),i("25f0"),i("5319"),i("96cf"),i("1da1")),o=i("d4ec"),r=i("bee2"),d=i("262e"),l=i("2caf"),c=i("9ab4"),u=i("60a3"),h=i("565f"),p=i("b650"),f=i("9ffb"),b=i("d1e1"),g=i("34e96"),m=i("ad06"),v=i("d282"),A=i("a142"),O=i("a8c1"),_=i("9884"),C=i("1325"),S=function(t){return{props:{closeOnClickOutside:{type:Boolean,default:!0}},data:function(){var e=this,i=function(i){e.closeOnClickOutside&&!e.$el.contains(i.target)&&e[t.method]()};return{clickOutsideHandler:i}},mounted:function(){Object(C["b"])(document,t.event,this.clickOutsideHandler)},beforeDestroy:function(){Object(C["a"])(document,t.event,this.clickOutsideHandler)}}},k=Object(v["a"])("dropdown-menu"),y=k[0],w=k[1],x=y({mixins:[Object(_["b"])("vanDropdownMenu"),S({event:"click",method:"onClickOutside"})],props:{zIndex:[Number,String],activeColor:String,overlay:{type:Boolean,default:!0},duration:{type:[Number,String],default:.2},direction:{type:String,default:"down"},closeOnClickOverlay:{type:Boolean,default:!0}},data:function(){return{offset:0}},computed:{scroller:function(){return Object(O["d"])(this.$el)},opened:function(){return this.children.some((function(t){return t.showWrapper}))},barStyle:function(){if(this.opened&&Object(A["c"])(this.zIndex))return{zIndex:1+this.zIndex}}},methods:{updateOffset:function(){if(this.$refs.bar){var t=this.$refs.bar.getBoundingClientRect();"down"===this.direction?this.offset=t.bottom:this.offset=window.innerHeight-t.top}},toggleItem:function(t){this.children.forEach((function(e,i){i===t?e.toggle():e.showPopup&&e.toggle(!1,{immediate:!0})}))},onClickOutside:function(){this.children.forEach((function(t){t.toggle(!1)}))}},render:function(){var t=this,e=arguments[0],i=this.children.map((function(i,n){return e("div",{attrs:{role:"button",tabindex:i.disabled?-1:0},class:w("item",{disabled:i.disabled}),on:{click:function(){i.disabled||t.toggleItem(n)}}},[e("span",{class:[w("title",{active:i.showPopup,down:i.showPopup===("down"===t.direction)}),i.titleClass],style:{color:i.showPopup?t.activeColor:""}},[e("div",{class:"van-ellipsis"},[i.slots("title")||i.displayTitle])])])}));return e("div",{class:w()},[e("div",{ref:"bar",style:this.barStyle,class:w("bar",{opened:this.opened})},[i]),this.slots("default")])}}),$=i("1421"),N=i("7744"),I=i("e41f"),D=Object(v["a"])("dropdown-item"),R=D[0],T=D[1],j=R({mixins:[Object($["a"])({ref:"wrapper"}),Object(_["a"])("vanDropdownMenu")],props:{value:null,title:String,disabled:Boolean,titleClass:String,options:{type:Array,default:function(){return[]}},lazyRender:{type:Boolean,default:!0}},data:function(){return{transition:!0,showPopup:!1,showWrapper:!1}},computed:{displayTitle:function(){var t=this;if(this.title)return this.title;var e=this.options.filter((function(e){return e.value===t.value}));return e.length?e[0].text:""}},watch:{showPopup:function(t){this.bindScroll(t)}},beforeCreate:function(){var t=this,e=function(e){return function(){return t.$emit(e)}};this.onOpen=e("open"),this.onClose=e("close"),this.onOpened=e("opened")},methods:{toggle:function(t,e){void 0===t&&(t=!this.showPopup),void 0===e&&(e={}),t!==this.showPopup&&(this.transition=!e.immediate,this.showPopup=t,t&&(this.parent.updateOffset(),this.showWrapper=!0))},bindScroll:function(t){var e=this.parent.scroller,i=t?C["b"]:C["a"];i(e,"scroll",this.onScroll,!0)},onScroll:function(){this.parent.updateOffset()},onClickWrapper:function(t){this.getContainer&&t.stopPropagation()}},render:function(){var t=this,e=arguments[0],i=this.parent,n=i.zIndex,s=i.offset,a=i.overlay,o=i.duration,r=i.direction,d=i.activeColor,l=i.closeOnClickOverlay,c=this.options.map((function(i){var n=i.value===t.value;return e(N["a"],{attrs:{clickable:!0,icon:i.icon,title:i.text},key:i.value,class:T("option",{active:n}),style:{color:n?d:""},on:{click:function(){t.showPopup=!1,i.value!==t.value&&(t.$emit("input",i.value),t.$emit("change",i.value))}}},[n&&e(m["a"],{class:T("icon"),attrs:{color:d,name:"success"}})])})),u={zIndex:n};return"down"===r?u.top=s+"px":u.bottom=s+"px",e("div",[e("div",{directives:[{name:"show",value:this.showWrapper}],ref:"wrapper",style:u,class:T([r]),on:{click:this.onClickWrapper}},[e(I["a"],{attrs:{overlay:a,position:"down"===r?"top":"bottom",duration:this.transition?o:0,lazyRender:this.lazyRender,overlayStyle:{position:"absolute"},closeOnClickOverlay:l},class:T("content"),on:{open:this.onOpen,close:this.onClose,opened:this.onOpened,closed:function(){t.showWrapper=!1,t.$emit("closed")}},model:{value:t.showPopup,callback:function(e){t.showPopup=e}}},[c,this.slots("default")])])])}}),B=i("9f14"),P=i("e27c"),V=i("d399"),z=i("6e47"),L=i("543e"),W=i("6b41"),H=i("f253"),M=(i("fdc4"),i("0147"),i("17d1"),i("1885"),i("681e"),i("0662"),i("b4eb"),i("339f"),i("7597"),i("2477"),i("c2d8"),i("e815"),i("b657"),i("9a5b"),i("5b4d"),i("36d1")),E=i("5487"),q=i("7c42"),F=i("ac6d"),J=i("bb62"),U=i("481f"),X=i("f9e9");u["c"].use(h["a"]).use(p["a"]).use(f["a"]).use(b["a"]).use(g["a"]).use(m["a"]).use(x).use(j).use(B["a"]).use(P["a"]).use(V["a"]).use(z["a"]).use(L["a"]).use(W["a"]).use(H["a"]);var G=function(t){Object(d["a"])(i,t);var e=Object(l["a"])(i);function i(){var t;return Object(o["a"])(this,i),t=e.apply(this,arguments),t.bodyHeight=0,t.inputName="",t.inputAddressValue="",t.middleTitleText="",t.rightTitleText="",t.isLoadingAccount=!0,t.isDisableInputAddress=!1,t.isDisableInputName=!1,t.isShowAddressPopup=!1,t.isShowRecord=!1,t.addressList=Array(),t.isDisableAddAdminRadio=!1,t.addressHintInfo="",t.AddAdmin=M["a"].AddAdmin,t.DeleteAdmin=M["a"].DeleteAdmin,t.radioAuthBtnValue=M["a"].None,t.SeparateSymbol=";",t.addressRightIcon=J["a"].ICON_ARROW_DOWN,t}return Object(r["a"])(i,[{key:"created",value:function(){this.$store.state.title=this.$t("managerSetting"),this.middleTitleText=this.$t("managerSetting").toString(),this.rightTitleText=this.$t("authRecord").toString(),this.bodyHeight=document.documentElement.clientHeight}},{key:"mounted",value:function(){var t=Object(a["a"])(regeneratorRuntime.mark((function t(){var e,i,n,s;return regeneratorRuntime.wrap((function(t){while(1)switch(t.prev=t.next){case 0:if(e=[],null!==J["a"].loadContractAddress()&&""!==J["a"].loadContractAddress()){t.next=5;break}return q["a"].show(this.$t("contractAddressIsNull").toString()),this.isLoadingAccount=!1,t.abrupt("return");case 5:return t.prev=5,t.next=8,E["b"].getInstance().loadOriginalList(X["a"].instance().address());case 8:e=t.sent,this.isLoadingAccount=!1,t.next=17;break;case 12:return t.prev=12,t.t0=t["catch"](5),this.isLoadingAccount=!1,q["a"].show(this.$t("unknownErrorPlsRecheck").toString()),t.abrupt("return");case 17:if(0!==e.length){t.next=20;break}return q["a"].show(this.$t("emptyChainData").toString()),t.abrupt("return");case 20:for(console.log("columns.length :"+e.length),e.length===J["a"].MAX_ADMIN_COUNT?(this.addressHintInfo=this.$t("plsChooseAddress").toString(),this.isDisableInputAddress=!0,this.isDisableInputName=!0,this.isDisableAddAdminRadio=!0,this.radioAuthBtnValue=this.DeleteAdmin,this.addressRightIcon=J["a"].ICON_ARROW_DOWN):(this.addressHintInfo=this.$t("plsChooseOrInputAddress").toString(),this.isDisableInputAddress=!1,this.radioAuthBtnValue=this.AddAdmin,this.addressRightIcon=J["a"].ICON_SCAN),this.$store.commit("emptyOriginalAddress"),i=0;i<e.length;i++)n=i,this.addressList.push(e[n].name+this.SeparateSymbol+e[n].address),s=e[n],this.$store.commit("addOriginalAddressModel",s),e[n].address.toLowerCase()===X["a"].instance().address().toLowerCase()&&(this.isShowRecord=!0);case 24:case"end":return t.stop()}}),t,this,[[5,12]])})));function e(){return t.apply(this,arguments)}return e}()},{key:"onClickBack",value:function(){this.$router.replace({name:"cert_search"})}},{key:"onClickRight",value:function(){this.$router.push({name:"auth_admin_record"})}},{key:"nextStep",value:function(){if(this.addressList.length!==J["a"].MAX_ADMIN_COUNT-1||this.radioAuthBtnValue!==this.DeleteAdmin)if(this.radioAuthBtnValue===this.AddAdmin||this.radioAuthBtnValue===this.DeleteAdmin)if(this.inputAddressValue&&this.inputName){var t=new M["b"];t.targetTxName=this.inputName,t.targetTxAddress=this.inputAddressValue,t.nowAdminAddress=X["a"].instance().address(),console.log("entry page authTx.nowAdminAddress===>"+t.nowAdminAddress+"||"+X["a"].instance().address()),this.radioAuthBtnValue===this.AddAdmin?t.authType=M["a"].AddAdmin:t.authType=M["a"].DeleteAdmin,this.$store.commit("updateAdminModel",t),this.$router.push({name:"original/confirm"})}else q["a"].show(this.$t("inputNotNull").toString());else q["a"].show(this.$t("operationTypeSelect").toString());else q["a"].fail(this.$t("forbidDeleteAdmin").toString())}},{key:"clickAddressInput",value:function(){var t=this;this.AddAdmin===this.radioAuthBtnValue?U["a"].instance().callNativeQrScanToJs().then((function(e){t.inputAddressValue="",t.inputAddressValue=e,Object(F["a"])(e)||q["a"].fail("不符合标准地址格式，请您再检查地址信息")})):this.isShowAddressPopup=!0}},{key:"confirmPickerAddress",value:function(t){if(this.isShowAddressPopup=!1,t){var e=t.indexOf(this.SeparateSymbol);this.inputName=t.substring(0,e),this.inputAddressValue=t.substring(e+1,t.length);var i=new M["b"];i.targetTxName=this.inputName,i.targetTxAddress=this.inputAddressValue}}},{key:"Change",value:function(t,e){t===this.AddAdmin&&t!==e&&(this.inputAddressValue="",this.inputName=""),this.$store.state.authOriginalTxModel.originalAddressModelList.length===J["a"].MAX_ADMIN_COUNT?(this.isDisableAddAdminRadio=!0,this.addressRightIcon=J["a"].ICON_ARROW_DOWN):(this.isDisableAddAdminRadio=!1,t===this.AddAdmin?this.addressRightIcon=J["a"].ICON_SCAN:this.addressRightIcon=J["a"].ICON_ARROW_DOWN)}}]),i}(u["c"]);Object(c["a"])([Object(u["d"])("radioAuthBtnValue",{immediate:!0,deep:!0})],G.prototype,"Change",null),G=Object(c["a"])([Object(u["a"])({})],G);var Q=G,K=Q,Y=(i("a19f"),i("2877")),Z=Object(Y["a"])(K,n,s,!1,null,"ccb84662",null);e["default"]=Z.exports},dfda:function(t,e,i){},e27c:function(t,e,i){"use strict";var n=i("d282"),s=i("78eb"),a=i("9884"),o=Object(n["a"])("radio-group"),r=o[0],d=o[1];e["a"]=r({mixins:[Object(a["b"])("vanRadio"),s["a"]],props:{value:null,disabled:Boolean,direction:String,checkedColor:String,iconSize:[Number,String]},watch:{value:function(t){this.$emit("change",t)}},render:function(){var t=arguments[0];return t("div",{class:d([this.direction]),attrs:{role:"radiogroup"}},[this.slots()])}})},efee:function(t,e,i){}}]);
//# sourceMappingURL=chunk-17145e97.8c9c1a97.js.map