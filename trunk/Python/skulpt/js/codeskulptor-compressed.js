var e=e||{};e.CSView=function(t,n){var r,i,s,o=function(){this.folder=e.newFoldFunction(e.pythonRangeFinder);var n=function(e){var t=e.getCursor(!0),n=e.getCursor(!1),r=t.line,i=n.line;n.ch===0?i-=1:n.ch+=1,e.operation(function(){for(var s=r;s<=i;s++){var o=e.getLine(s);e.setLine(s,"#"+o)}e.setSelection(t,n)})},r=function(e){var t=e.getCursor(!0),n=e.getCursor(!1),r=t.line,i=n.line;n.ch===0&&(i-=1);var s=/^(\s*)\#/;e.operation(function(){var o,u;for(var a=r;a<=i;a++)o=e.getLine(a),u=o.replace(s,"$1"),o!==u&&e.setLine(a,u);o!==u&&n.ch!==0&&(n.ch-=1),e.setSelection(t,n)})};this.tabStop=4,this.editor=CodeMirror.fromTextArea(t("#code")[0],{mode:{name:"python",version:2,singleLineStringErrors:!1},gutters:["fold-gutter"],fixedGutter:!1,lineNumbers:!0,indentUnit:this.tabStop,tabMode:"indent",matchBrackets:!0,extraKeys:{"Ctrl-Q":function(e){o.folder(e,e.getCursor().line)},"Ctrl-K":n,"Shift-Ctrl-K":r}}),this.editor.on("gutterClick",this.folder),this.errorLine=null,this.pre=null;var i={console:"#console",splitBar:"#splitbar",grip:"#grip",runButton:"#run",saveButton:"#save",dlButton:"#dl",freshButton:"#fresh",loadLocalButton:"#loadlocal",resetButton:"#reset",docButton:"#docs",demoButton:"#demos",tipsButton:"#tips",localFile:"#localfile",dlanchor:"#dlhref",topbar:"#controls",brand:"#brand"};for(var s in i)this[s]=t(i[s]);var o=this;CodeMirror.commands.save=function(e){o.saveButton.click()},this.minheight=this.console.height();var u=this.console.offset().top,a=t("#bottom").height()*3;this.extraheight=u+a,this.split=!0,this.edwidth=t(this.editor.getWrapperElement()).width(),this.conwidth=this.console.width(),this.width=this.edwidth+this.conwidth},u=function(e,t){if(e[t])return e[t]();if(document.createEvent){var n=document.createEvent("HTMLEvents");return n.initEvent(t,!0,!0),!e.dispatchEvent(n)}var n=document.createEventObject();return e.fireEvent("on"+t,n)};return o.prototype.configure=function(e){this.model=e,this.runButton.button({text:!1,icons:{primary:"ui-icon-play"}}),this.saveButton.button({text:!1,icons:{primary:"ui-icon-disk"}}),this.dlButton.button({text:!1,disabled:!0,icons:{primary:"ui-icon-arrowthickstop-1-s"}}),this.freshButton.button({text:!1,icons:{primary:"ui-icon-suitcase"}}),this.loadLocalButton.button({text:!1,icons:{primary:"ui-icon-folder-open"}}),this.resetButton.button({text:!1,icons:{primary:"ui-icon-arrowreturnthick-1-w"}}),this.docButton.button({icons:{primary:"ui-icon-info"}}),this.demoButton.button({icons:{primary:"ui-icon-script"}}),this.tipsButton.button({icons:{primary:"ui-icon-lightbulb"}})},r=function(e,t){var n=e.width-t;e.editor.setSize(t,null),n|=0,e.console.width(n),e.editor.refresh()},i=function(e,t){t-=e.extraheight,t<e.minheight&&(t=e.minheight),e.editor.setSize(null,t),e.splitBar.height(t),e.grip[0].style.top=t/2-e.grip.height()/2+"px",e.console.height(t),e.editor.refresh()},s=function(e,t){var n=t.parentNode;while(n!==null){if(n===e)return!0;n=n.parentNode}return!1},o.prototype.start=function(){var e,o,a,f,l,c=this.model,h=this,p=document.getElementById("active"),d=function(e,t){var n=e/2-t/2;h.brand.css({left:n+"px"})};this.brand.load(function(){var e=h.topbar.outerWidth(),t=h.brand.width();d(e,t)}),d(this.topbar.outerWidth(),129),this.runButton.click(function(){h.runButton.blur(),c.run()}),this.saveButton.click(function(){h.saveButton.blur(),c.save()}),this.freshButton.click(function(){h.freshButton.blur(),c.save(!0)}),this.dlButton.click(function(){var e,n,r=h.dlanchor[0];h.dlButton.blur(),e=r.href,n=t.ajax({url:e,type:"GET",success:function(){u(r,"click")},error:function(){u(r,"click")}})}),e=function(e){var t=p,r=0,i=0;while(t&&t.tagName!="BODY")r+=t.offsetTop,i+=t.offsetLeft,t=t.offsetParent;return{x:e.clientX-i+n.pageXOffset,y:e.clientY-r+n.pageYOffset}},o=function(t){var n=e(t),i=n.x>=h.width?h.width:n.x;r(h,i),h.edwidth=i,h.conwidth=h.width-h.edwidth,h.split=!0},a=function(e){p.removeEventListener("mousemove",o,!0),p.removeEventListener("mouseup",a,!0),p.removeEventListener("mouseout",f,!0)},f=function(e){var t=e.toElement;t!==p&&!s(p,t)&&(p.removeEventListener("mousemove",o,!0),p.removeEventListener("mouseup",a,!0),p.removeEventListener("mouseout",f,!0))},this.splitBar.hover(function(){t(this).css("cursor","col-resize")},function(){t(this).css("cursor","auto")}),this.splitBar.mousedown(function(){return document.body.focus(),p.addEventListener("mousemove",o,!0),p.addEventListener("mouseup",a,!0),p.addEventListener("mouseout",f,!0),!1}),this.splitBar.dblclick(function(){h.split?(r(h,h.width),h.split=!1):(r(h,h.edwidth),h.split=!0)}),n.onresize=function(){var e=t(n).height();i(h,e)},i(h,t(n).height()),l=function(e){var t=e.target.files[0];c.loadLocal(t)},this.localFile.on("change",l),t(document).on("change","#localfile",l),this.loadLocalButton.click(function(){h.loadLocalButton.blur(),navigator.userAgent.indexOf("Firefox")!=-1&&h.localFile.click()}),this.resetButton.click(function(){h.resetButton.blur(),c.reset()}),this.docButton.click(function(){var e;h.docButton.blur(),e=document.getElementById("docanchor"),u(e,"click")}),this.demoButton.click(function(){var e;h.demoButton.blur(),e=document.getElementById("demoanchor"),u(e,"click")}),this.tipsButton.click(function(){var e;h.tipsButton.blur(),e=document.getElementById("tipanchor"),u(e,"click")}),t(n).bind("hashchange",function(){c.loadRemote(n.location.hash)}),this.model.loadRemote(n.location.hash)},o.prototype.setFilename=function(e){n.location.hash=e},o.prototype.showDownload=function(e){var t=this,n=function(e,r){t.dlButton.button("option","disabled",!0),t.saveButton.button("option","disabled",!1),t.editor.off("change",n),t.saveButton.blur(),t.saveButton.removeClass("ui-state-hover")};this.dlanchor.attr("href",e),this.dlButton.button("option","disabled",!1),this.saveButton.button("option","disabled",!0),this.editor.on("change",n)},o.prototype.getEditState=function(){var e,t,n,r,i,s,o=this.editor.getScrollInfo(),u=this.editor.getCursor(),a=[],f=!1;for(e=0,t=this.editor.lineCount();e<t;++e){n=this.editor.findMarksAt({line:e,ch:0}),r=!1;for(i=0;i<n.length;++i)n[i].__isFold&&(r=!0,f||(a.push(e-1),f=!0));f&&!r&&(f=!1)}return s={x:o.left,y:o.top,cursor:u,folded:a},s},o.prototype.setCode=function(e,t){var n,r=this.editor,i=this.folder;r.setValue(e);if(t){r.setCursor(t.cursor),r.scrollTo(t.x,t.y);for(n=0;n<t.folded.length;n++)i(r,t.folded[n])}},o.prototype.getCode=function(){return this.editor.getValue()},o.prototype.getTabStop=function(){return this.tabStop},o.prototype.setHash=function(e){n.location.hash=e},o.prototype.consoleOutput=function(e){var n;this.pre||(this.pre=t("<pre />"),this.console.append(this.pre)),n=t("<div />").text(e).html(),this.pre.append(n),this.console.scrollTop(this.console.prop("scrollHeight"))},o.prototype.colorOutput=function(e,n){var r,i=t("<pre />"),s=t("<span />");s.css("color",n),r=t("<div />").text(e).html(),s.append(r),i.append(s),this.console.append(i),this.console.scrollTop(this.console.prop("scrollHeight")),this.pre=null},o.prototype.exceptOutput=function(e,t,n){var r="",i=n(),s=t();i&&(r+="File '"+i+"', "),s&&(r+="Line "+s+": "),r+=e,this.colorOutput(r,"red"),s&&i===undefined&&(this.errorLine=this.editor.addLineClass(s-1,"background","activeline"),this.editor.setCursor(s-1),this.editor.focus())},o.prototype.reset=function(){this.errorLine&&(this.editor.removeLineClass(this.errorLine,"background","activeline"),this.errorLine=null),this.console.html(""),this.pre=null,CodeMirror.commands.clearSearch!==undefined&&CodeMirror.commands.clearSearch(this.editor)},o}(jQuery,window),e=e||{},e.pythonRangeFinder=function(e,t){var n,r,i,s=e.getOption("tabSize"),o=e.getLine(t.line),u=CodeMirror.countColumn(o,null,s),a=null;for(n=t.line+1,r=e.lineCount();n<r;++n){i=e.getLine(n);if(!/^\s*(?:\#.*)?$/.test(i)){if(CodeMirror.countColumn(i,null,s)<=u)break;a=n}}return a?{from:{line:t.line,ch:o.length},to:{line:a,ch:e.getLine(a).length}}:null},e.newFoldFunction=function(e,t){var n;return t==null&&(t="↔"),typeof t=="string"&&(n=document.createTextNode(t),t=document.createElement("span"),t.appendChild(n),t.className="CodeMirror-foldmarker"),function(n,r){var i,s,o,u,a,f,l;typeof r=="number"&&(r={line:r,ch:0}),i=e(n,r);if(!i)return;s=n.findMarksAt(i.from),o=0;for(u=0;u<s.length;++u)s[u].__isFold&&(++o,s[u].clear());if(o){n.setGutterMarker(r.line,"fold-gutter",null);return}a=t.cloneNode(!0),f=n.markText(i.from,i.to,{replacedWith:a,clearOnEnter:!0,__isFold:!0}),CodeMirror.on(a,"mousedown",function(){f.clear()}),CodeMirror.on(f,"clear",function(){n.setGutterMarker(r.line,"fold-gutter",null)}),l=document.createElement("span"),l.appendChild(document.createTextNode("▶")),l.style.color="#600",n.setGutterMarker(r.line,"fold-gutter",l)}},e=e||{},e.GoogleData={baseURL:"http://codeskulptor-{0}.commondatastorage.googleapis.com/",writeBucket:"user26",googleid:"GOOGB6HNKIBQBT2CTYD6",policy:"eyJleHBpcmF0aW9uIjogIjIwMTMtMTItMjdUMTI6MDA6MDAuMDAwWiIsCgogICJjb25kaXRpb25zIjogWwogICAgeyJidWNrZXQiOiAiY29kZXNrdWxwdG9yLXVzZXIyNiJ9LAogICAgWyJzdGFydHMtd2l0aCIsICIka2V5IiwgInVzZXIyNiJdLAogICAgWyJlcSIsICIkQ29udGVudC1UeXBlIiwgInRleHQveC1weXRob24iXSwKICAgIFsiY29udGVudC1sZW5ndGgtcmFuZ2UiLCAwLCA2NTUzNl0KICBdCn0K",signature:"0jpmKJ3+JocqTKL1bs76LaH21HU="},e=e||{},String.prototype.format=function(){var e=arguments;return this.replace(/{(\d+)}/g,function(t,n){return typeof e[n]!="undefined"?e[n]:t})},e.CSModel=function(e){var t,n,r,i,s,o,u,a=function(e,t,n){this.bucket=undefined,this.uid=undefined,this.seqnum=undefined,this.ext=undefined,this.filename=undefined,this.hashLen=e,this.shareLen=1.5*e|0,this.baseURL=t,this.writeBucket=n},f=".py",l=4;return a.prototype.configure=function(e){this.view=e},t='# CodeSkulptor runs Python programs in your browser.\n# Click the upper left button to run this simple demo.\n\n# CodeSkulptor runs in Chrome 18+, Firefox 11+, and Safari 6+.\n# Some features may work in other browsers, but do not expect\n# full functionality.  It does NOT run in Internet Explorer.\n\nimport simplegui\n\nmessage = "Welcome!"\n\n# Handler for mouse click\ndef click():\n    global message\n    message = "Good job!"\n\n# Handler to draw on canvas\ndef draw(canvas):\n    canvas.draw_text(message, [50,112], 48, "Red")\n\n# Create a frame and assign callbacks to event handlers\nframe = simplegui.create_frame("Home", 300, 200)\nframe.add_button("Click me", click)\nframe.set_draw_handler(draw)\n\n# Start the frame animation\nframe.start()\n',a.prototype.spaceRE=/^ *\t[ \t]*/gm,a.prototype.spacesForTabs=function(e){return function(t){var n,r,i="";for(n=0;n<t.length;n++)t.charAt(n)==="	"?(r=e-i.length%e,i+=Array(r+1).join(" ")):i+=" ";return i}},a.prototype.start=function(){var n=this,r=function(e){var t=/^\.\/([a-zA-Z][a-zA-Z0-9]*)\_([\w]+?)(?:\_(\d+))?\.py$/,n=e.match(t),r,i,s,o;return n==null?null:(r=n[1],i=n[2],n[3]===undefined?s=null:s=parseInt(n[3]),o=r+"_"+i,s!=null&&(o+="_"+s),o+=".py",console.log("Import: bucket: "+r+" uid: "+i+" seqnum: "+s+" filename: "+o),{bucket:r,filename:o})},i=function(t){if(Sk.builtinFiles!==undefined&&Sk.builtinFiles.files[t]!==undefined)return Sk.builtinFiles.files[t];var i=r(t);if(i!==null){var s=n.baseURL.format(i.bucket)+i.filename,o={async:!1,error:function(e,n,r){throw"File not found: '"+t+"'"},timeout:5e3},u=e.ajax(s,o).responseText,a=n.view.getTabStop();return u=u.replace(n.spaceRE,n.spacesForTabs(a)),Sk.execStart=new Date,u}throw"File not found: '"+t+"'"};Sk.configure({output:this.view.stdout,debugout:this.view.stddbg,read:i,error:this.view.stderr}),this.view.setCode(t)},n="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789",a.prototype.createHash=function(e){var t,r="",i=e||this.hashLen;for(t=0;t<i;t++)r+=n.charAt(Math.random()*n.length|0);return r},a.prototype.getLineNo=function(){return Sk.currLineNo?Sk.currLineNo:undefined},a.prototype.getFilename=function(){var e;return Sk.currFilename&&Sk.currFilename!=="<stdin>.py"?(e=Sk.currFilename.split("/"),e[e.length-1]):undefined},a.prototype.reset=function(){Sk.simplegui&&(Sk.simplegui.cleanup(),Sk.simplegui=undefined),Sk.simpleplot&&(Sk.simpleplot.cleanup(),Sk.simpleplot=undefined),this.view.reset()},a.prototype.run=function(){var e,t,n,r,i,s,o,u=this.view.getTabStop();try{e=this.view.getCode(),t=this.view.getEditState(),e=e.replace(this.spaceRE,this.spacesForTabs(u)),this.view.setCode(e,t),this.reset(),Sk.currLineNo=undefined,Sk.currColNo=undefined,Sk.currFilename=undefined,Sk.setExecLimit(5e3),n=Sk.importMainWithBody("<stdin>",!1,e)}catch(a){if(a instanceof Sk.builtin.ParseError||a instanceof Sk.builtin.SyntaxError||a instanceof Sk.builtin.IndentationError||a instanceof Sk.builtin.TokenError)try{a.args.v[2]!==undefined&&(Sk.currLineNo=a.args.v[2]),a.args.v[1]!==undefined&&(Sk.currFilename=a.args.v[1].v),r=a.args.v[3][0][1],i=a.args.v[3][1][1],s=a.args.v[3][2].substring(r,i),a.args.v[0]=a.args.v[0].sq$concat(new Sk.builtin.str(" ('"+s+"')"))}catch(f){}o=a.tp$name+": "+a,this.view.stderr(o),Sk.simplegui&&(Sk.simplegui.cleanup(),Sk.simplegui=undefined),Sk.simpleplot&&(Sk.simpleplot.cleanup(),Sk.simpleplot=undefined)}},r=function(e,t,n,r){var i=e+"_"+t;return n>=0&&(i+="_"+n.toString()),r===undefined?i+=f:i+=r,i},i=function(t,n,s,o){var u;o=o||1;if(o>l){alert("Unable to save at this time.");return}u=r(t.writeBucket,n,s),console.log("Save key: "+u+" attempt: "+o);var a=t.baseURL.format(t.writeBucket)+u,c=e.ajax({url:a,type:"HEAD",success:function(e,r){n=t.createHash(),s>=0&&(s=0),i(t,n,s,o++)},error:function(r,i,o){o=="Not Found"?(e("#keyid")[0].value=u,e("#codeform")[0].submit(),t.bucket=t.writeBucket,t.uid=n,t.seqnum=s,t.ext=f,t.filename=u,t.view.setHash(u),t.view.showDownload(a,u)):alert("Unable to save at this time.")}})},a.prototype.save=function(e){var t,n,r,s,o;e?(t=this.createHash(this.shareLen),n=-1):this.uid?(t=this.uid,n=this.seqnum+1):(t=this.createHash(),n=0),r=this.view.getTabStop(),s=this.view.getCode(),o=this.view.getEditState(),s=s.replace(this.spaceRE,this.spacesForTabs(r)),this.view.setCode(s,o),i(this,t,n)},s=function(e){e.uid?e.view.setHash(e.filename):e.view.setHash("")},o=function(e){var t=/^#([a-zA-Z][a-zA-Z0-9]*)[\-_]([\w\-]+?)(?:[\-_](\d+))?(\.py)$/,n=e.match(t),r,i,s,o;return n==null?null:(r=n[1],i=n[2],n[3]===undefined?s=-1:s=parseInt(n[3]),o=n[4],console.log("New: bucket: "+r+" uid: "+i+" seqnum: "+s+" ext: "+o),{bucket:r,uid:i,seqnum:s,ext:o})},a.prototype.loadRemote=function(t){var n,r,i,u,a;if(!t){this.bucket=undefined,this.uid=undefined,this.seqnum=undefined,this.ext=undefined,this.filename=undefined;return}n=o(t),r=t.slice(1);if(!n){alert("Invalid file name: "+r),s(this);return}if(this.filename==r)return;i=this,u=i.baseURL.format(n.bucket)+r,a=e.get(u),a.success(function(e){i.view.setCode(e),i.reset(),i.bucket=n.bucket,i.uid=n.uid,i.seqnum=n.seqnum,i.ext=n.ext,i.filename=r}),a.error(function(){s(i),alert("Unable to load file: "+r)})},u=function(e){var t="";switch(e.currentTarget.error.code){case FileError.QUOTA_EXCEEDED_ERR:t="QUOTA EXCEEDED";break;case FileError.NOT_FOUND_ERR:t="NOT FOUND";break;case FileError.SECURITY_ERR:t="SECURITY ERROR";break;case FileError.INVALID_MODIFICATION_ERR:t="INVALID MODIFICATION";break;case FileError.INVALID_STATE_ERR:t="INVALID STATE";break;default:t="Unknown Error"}alert("Error opening file: "+t)},a.prototype.loadLocal=function(e){var t=this,n=new FileReader;n.onload=function(e){t.view.setCode(e.target.result)},n.onerror=u,n.readAsText(e)},a}(jQuery),e=e||{},e.Controller=function(){var t,n,r,i;this.view=new e.CSView,this.model=new e.CSModel(10,e.GoogleData.baseURL,e.GoogleData.writeBucket),t=e.GoogleData.baseURL.format(e.GoogleData.writeBucket),$("#codeform")[0].action=t,$("#googleid")[0].value=e.GoogleData.googleid,$("#policy")[0].value=e.GoogleData.policy,$("#signature")[0].value=e.GoogleData.signature,n=function(e,t){return function(){return e.apply(t,arguments)}},r={stdout:n(this.view.consoleOutput,this.view),stddbg:n(function(e){this.view.colorOutput(e,"blue")},this),stderr:n(function(e){this.view.exceptOutput(e,this.model.getLineNo,this.model.getFilename)},this),setFilename:n(this.view.setFilename,this.view),showDownload:n(this.view.showDownload,this.view),getEditState:n(this.view.getEditState,this.view),setCode:n(this.view.setCode,this.view),getCode:n(this.view.getCode,this.view),getTabStop:n(this.view.getTabStop,this.view),setHash:n(this.view.setHash,this.view),reset:n(this.view.reset,this.view)},i={run:n(this.model.run,this.model),save:n(this.model.save,this.model),loadRemote:n(this.model.loadRemote,this.model),loadLocal:n(this.model.loadLocal,this.model),reset:n(this.model.reset,this.model)},this.view.configure(i),this.model.configure(r),this.model.start(),this.view.start()},jQuery(function(){var t=new e.Controller});