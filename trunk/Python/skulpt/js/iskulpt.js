// output functions are configurable.  This one just appends some text
// to a pre element.
function outf(text) {
    try {
		var mypre = document.getElementById(Sk.pre);
		mypre.innerHTML = mypre.innerHTML + text;
	} catch(e) { }
}
function builtinRead(x) {
    if (Sk.builtinFiles === undefined || Sk.builtinFiles["files"][x] === undefined)
            throw "File not found: '" + x + "'";
    return Sk.builtinFiles["files"][x];
}

function loadXMLDoc(dname) {
    if (window.XMLHttpRequest) {
        xhttp=new XMLHttpRequest();
    } else {
        xhttp=new ActiveXObject("Microsoft.XMLHTTP");
    }
    xhttp.open("GET",dname,false);
    xhttp.send();
    return xhttp.responseText;
}

function runit() {
    //var prog = document.getElementById("yourcode").value;
    var prog = loadXMLDoc(Sk.currFilename);
    var mypre = document.getElementById(Sk.pre);
    mypre.innerHTML = '';
    Sk.configure({output:outf, read:builtinRead});
    eval(Sk.importMainWithBody("<stdin>",false,prog));
}
