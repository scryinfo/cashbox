(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-9658de64"],{1785:function(t,s,a){"use strict";a("8ec9")},"8ec9":function(t,s,a){},c949:function(t,s,a){"use strict";a.r(s);var e=function(){var t=this,s=t.$createElement,a=t._self._c||s;return a("div",{staticClass:"account_info_page"},[a("div",{staticClass:"address_title_group"},[a("span",{staticClass:"address_title"},[t._v(" "+t._s(t.$t("nowAccountAddress")))])]),a("div",{staticClass:"address_text_content_group"},[a("span",{staticClass:"address_text_content"},[t._v(t._s(t.addressContent))])]),a("div",{staticClass:"address_img_content_group"},[a("v-qrcode",{staticClass:"address_qr_img_content",attrs:{code:t.qrCodeInfo}})],1),a("div",{staticClass:"contract_address_title_group"},[a("span",{staticClass:"contract_address_title"},[t._v(t._s(t.$t("contractAddress")))])]),a("div",{staticClass:"contract_address_content_group"},[t.isEditableCA?a("van-cell-group",{staticClass:"contract_address_content"},[a("van-field",{staticClass:"contract_address_content_input",attrs:{"right-icon":"scan"},on:{"click-right-icon":t.scanAddress},model:{value:t.contractAddressValue,callback:function(s){t.contractAddressValue=s},expression:"contractAddressValue"}})],1):t._e(),t.isEditableCA?t._e():a("span",{staticClass:"contract_address_content"},[t._v(" "+t._s(t.contractAddressValue))]),a("van-button",{staticClass:"contract_address_btn",attrs:{"van-button":"",plain:"",type:"info"},on:{click:t.editOrLoadContractAddress}},[t._v(t._s(t.editText)+" ")])],1),a("div",{staticClass:"other_params_title_group"},[a("span",{staticClass:"other_params_title_content"},[t._v(t._s(t.$t("otherParamsState")))])]),a("div",{staticClass:"left_available_group"},[a("span",{staticClass:"left_available_content"},[t._v(t._s(t.$t("leftAvailableCount"))+"："+t._s(t.availableCount))])]),a("div",{staticClass:"max_businessman_group"},[a("span",{staticClass:"max_businessman_content"},[t._v(t._s(t.$t("maxBusinessmanCount"))+"："+t._s(t.maxCurrentBusinessCount)+" ")])]),a("van-overlay",{attrs:{show:t.isLoadingAccount}},[a("van-loading",{staticClass:"loading_component",attrs:{type:"spinner",vertical:""}},[t._v(t._s(t.$t("dataLoading")))])],1)],1)},n=[],r=(a("d3b7"),a("25f0"),a("96cf"),a("1da1")),i=a("d4ec"),c=a("bee2"),o=a("262e"),d=a("2caf"),u=a("9ab4"),l=a("60a3"),_=a("b650"),h=a("565f"),C=a("34e96"),v=a("6e47"),p=a("543e"),b=(a("0147"),a("fdc4"),a("17d1"),a("e815"),a("b657"),a("7c42")),f=a("bb62"),g=a("5487"),A=a("4290"),m=a("481f"),x=a("f9e9");l["c"].use(_["a"]).use(h["a"]).use(C["a"]).use(v["a"]).use(p["a"]);var k=function(t){Object(o["a"])(a,t);var s=Object(d["a"])(a);function a(){var t;return Object(i["a"])(this,a),t=s.apply(this,arguments),t.addressContent="",t.contractAddressValue="",t.isEditableCA=!1,t.availableCount="",t.maxCurrentBusinessCount="0",t.editText="",t.isLoadingAccount=!1,t.qrCodeInfo="",t}return Object(c["a"])(a,[{key:"created",value:function(){this.$store.state.title=this.$t("accountInfo")}},{key:"mounted",value:function(){var t=Object(r["a"])(regeneratorRuntime.mark((function t(){return regeneratorRuntime.wrap((function(t){while(1)switch(t.prev=t.next){case 0:if(this.addressContent=x["a"].instance().address(),this.qrCodeInfo=x["a"].instance().address(),this.contractAddressValue=f["a"].loadContractAddress(),null!==this.contractAddressValue&&""!==this.contractAddressValue){t.next=7;break}return this.isLoadingAccount=!1,b["a"].show(this.$t("contractAddressIsNull").toString()),t.abrupt("return");case 7:if(this.contractAddressValue.length===f["a"].StandardAddressLength){t.next=10;break}return b["a"].show(this.$t("caLengthIsWrong").toString()),t.abrupt("return");case 10:this.doLoadChinInfo();case 11:case"end":return t.stop()}}),t,this)})));function s(){return t.apply(this,arguments)}return s}()},{key:"stateChange",value:function(){this.isEditableCA?this.editText=this.$t("save").toString():this.editText=this.$t("edit").toString()}},{key:"doLoadChinInfo",value:function(){var t=Object(r["a"])(regeneratorRuntime.mark((function t(){var s,a;return regeneratorRuntime.wrap((function(t){while(1)switch(t.prev=t.next){case 0:return this.maxCurrentBusinessCount="0",this.availableCount="0",this.isLoadingAccount=!0,t.prev=3,t.next=6,g["b"].getInstance().loadContractUsedCount();case 6:return s=t.sent,t.next=9,g["b"].getInstance().loadContractMaxCount();case 9:return a=t.sent,t.next=12,g["b"].getInstance().loadMaxCurrentBusinessCount();case 12:this.maxCurrentBusinessCount=t.sent,this.availableCount=(parseInt(a)-parseInt(s)).toString(),this.isLoadingAccount=!1,t.next=21;break;case 17:t.prev=17,t.t0=t["catch"](3),this.isLoadingAccount=!1,b["a"].fail(this.$t("plsCheckCaInfo").toString());case 21:case"end":return t.stop()}}),t,this,[[3,17]])})));function s(){return t.apply(this,arguments)}return s}()},{key:"editOrLoadContractAddress",value:function(){if(this.isEditableCA)return this.contractAddressValue.length!==f["a"].StandardAddressLength?void b["a"].show(this.$t("caLengthIsWrong").toString()):(m["a"].instance().callNativeEditOrLoadCA(this.contractAddressValue),f["a"].setContractAddress(this.contractAddressValue),this.doLoadChinInfo(),void(this.isEditableCA=!1));this.isEditableCA=!0}},{key:"scanAddress",value:function(){var t=this;m["a"].instance().callNativeQrScanToJs().then((function(s){t.contractAddressValue=s}))}}]),a}(l["c"]);Object(u["a"])([Object(l["d"])("isEditableCA",{immediate:!0,deep:!0})],k.prototype,"stateChange",null),k=Object(u["a"])([Object(l["a"])({components:{VQrcode:A["a"]}})],k);var w=k,L=w,I=(a("1785"),a("2877")),$=Object(I["a"])(L,e,n,!1,null,"3d324fd3",null);s["default"]=$.exports}}]);
//# sourceMappingURL=chunk-9658de64.842a76a5.js.map