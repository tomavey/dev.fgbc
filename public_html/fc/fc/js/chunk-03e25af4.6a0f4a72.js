(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-03e25af4"],{"26e5":function(t,e,i){},"708c":function(t,e,i){},a10f:function(t,e,i){"use strict";var a=i("708c"),n=i.n(a);n.a},e32e:function(t,e,i){"use strict";i.r(e);var a=function(){var t=this,e=t.$createElement,i=t._self._c||e;return i("v-app",[i("v-container",[i("v-form",{model:{value:t.valid,callback:function(e){t.valid=e},expression:"valid"}},[i("p",[t._v("Documents (files, pics etc)")]),i("wysiwyg",{model:{value:t.idea,callback:function(e){t.idea=e},expression:"idea"}}),i("v-text-field",{attrs:{label:"Link to a resource: provide a valid URL"},model:{value:t.link,callback:function(e){t.link=e},expression:"link"}}),t.filename.length?t._e():i("v-layout",{attrs:{row:""}},[i("v-flex",{attrs:{xs12:""}},[t.filename.length?i("p",[t._v("File Selected: "+t._s(t.filename))]):t._e(),i("v-btn",{staticClass:"primary",attrs:{raised:"",block:""},on:{click:t.onPickFile}},[t._v(" "+t._s(t.imageButtonText)+" "),i("v-icon",{attrs:{right:"",dark:""}},[t._v("cloud_upload")])],1),i("input",{ref:"fileInput",staticStyle:{display:"none"},attrs:{type:"file"},on:{change:t.onFilePicked}})],1)],1),t.filename.length?i("v-layout",{attrs:{row:""}},[i("v-flex",{attrs:{xs12:""}},[t.filename.length?i("p",[t._v("File Selected: "+t._s(t.filename))]):t._e()])],1):t._e(),i("v-btn",{attrs:{raised:"",color:"success",large:"",block:"",disabled:!t.valid},on:{click:t.submit}},[t._v(" Submit your resource! "),i("v-icon",{attrs:{right:"",dark:""}},[t._v("input")])],1)],1)],1)],1)},n=[],r={data:function(){return{message:"Documents Dialog",name:"",link:"",filename:"",key:"",idea:"",email:"",authorPhone:"",imageButtonText:"Select a file from your device to upload.",valid:!1,nameRules:[function(t){return!!t||"Name is required"},function(t){return t.length>=5||"Name must be greater than 5 characters"}],emailRules:[function(t){return!!t||"E-mail is required"},function(t){return/^\w+([.-]?\w+)*@\w+([.-]?\w+)*(\.\w{2,3})+$/.test(t)||"E-mail must be valid"}]}}},s=r,u=(i("a10f"),i("2877")),l=i("6544"),o=i.n(l),c=i("7496"),d=i("8336"),f=i("a523"),h=i("0e8f"),v=(i("26e5"),i("94ab")),m={name:"v-form",mixins:[Object(v["b"])("form")],inheritAttrs:!1,props:{value:Boolean,lazyValidation:Boolean},data:function(){return{inputs:[],watchers:[],errorBag:{}}},watch:{errorBag:{handler:function(){var t=Object.values(this.errorBag).includes(!0);this.$emit("input",!t)},deep:!0,immediate:!0}},methods:{watchInput:function(t){var e=this,i=function(t){return t.$watch("hasError",(function(i){e.$set(e.errorBag,t._uid,i)}),{immediate:!0})},a={_uid:t._uid,valid:void 0,shouldValidate:void 0};return this.lazyValidation?a.shouldValidate=t.$watch("shouldValidate",(function(n){n&&(e.errorBag.hasOwnProperty(t._uid)||(a.valid=i(t)))})):a.valid=i(t),a},validate:function(){var t=this.inputs.filter((function(t){return!t.validate(!0)})).length;return!t},reset:function(){for(var t=this,e=this.inputs.length;e--;)this.inputs[e].reset();this.lazyValidation&&setTimeout((function(){t.errorBag={}}),0)},resetValidation:function(){for(var t=this,e=this.inputs.length;e--;)this.inputs[e].resetValidation();this.lazyValidation&&setTimeout((function(){t.errorBag={}}),0)},register:function(t){var e=this.watchInput(t);this.inputs.push(t),this.watchers.push(e)},unregister:function(t){var e=this.inputs.find((function(e){return e._uid===t._uid}));if(e){var i=this.watchers.find((function(t){return t._uid===e._uid}));i.valid&&i.valid(),i.shouldValidate&&i.shouldValidate(),this.watchers=this.watchers.filter((function(t){return t._uid!==e._uid})),this.inputs=this.inputs.filter((function(t){return t._uid!==e._uid})),this.$delete(this.errorBag,e._uid)}}},render:function(t){var e=this;return t("form",{staticClass:"v-form",attrs:Object.assign({novalidate:!0},this.$attrs),on:{submit:function(t){return e.$emit("submit",t)}}},this.$slots.default)}},p=i("132d"),_=i("a722"),g=i("2677"),w=Object(u["a"])(s,a,n,!1,null,null,null);e["default"]=w.exports;o()(w,{VApp:c["a"],VBtn:d["a"],VContainer:f["a"],VFlex:h["a"],VForm:m,VIcon:p["a"],VLayout:_["a"],VTextField:g["a"]})}}]);
//# sourceMappingURL=chunk-03e25af4.6a0f4a72.js.map