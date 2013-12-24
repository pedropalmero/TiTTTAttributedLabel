// This is a test harness for your module
// You should do something interesting in this harness 
// to test out the module and to provide instructions 
// to users on how to use it by example.


// open a single window
var win = Ti.UI.createWindow({
	backgroundColor:'white',
	layout: "vertical",
	top: "20dp"
});

var scrollView = Ti.UI.createScrollView({
  contentWidth: 'auto',
  contentHeight: 'auto',
  showVerticalScrollIndicator: true,
  showHorizontalScrollIndicator: true,
  layout: "vertical"
});
win.add(scrollView);

var createSeparator = function() {
   return Ti.UI.createView({
       height: "2dp",
       width: Ti.UI.FILL,
       top: "10dp",
       bottom: "10dp",
       backgroundColor: "orange" 
    });
};

// TODO: write your module tests here
var TiTTTAttributedLabel = require('com.codingpie.titttattributedlabel');
Ti.API.info("module is => " + TiTTTAttributedLabel);

var text = "Los sistemas computacionales, generalmente implementados como dispositivos electrónicos, permiten el procesamiento automático de la información. Conforme a ello, los sistemas informáticos deben realizar las siguientes tres tareas básicas: Entrada: captación de la información. Normalmente son datos y órdenes ingresados por los usuarios a través de cualquier dispositivo de entrada conectado al ordenador. Proceso: tratamiento de la información. Se realiza a través de programas y aplicaciones diseñadas por programadores que indican de forma secuencial cómo resolver un requerimiento. Salida: transmisión de resultados. A través de los dispositivos de salida los usuarios pueden visualizar los resultados que surgen del procesamiento de los datos.";
text += " http://www.elmundo.es 91-0025125 910025125 calle Alcala 1, 28001, Madrid";

var label = TiTTTAttributedLabel.createLabel({
   text: "Lorem ipsum dolor amet (1)",
   width: Ti.UI.FILL,
   height: "20dp",
   textCheckingTypes: TiTTTAttributedLabel.CHECKING_TYPE_LINK
});

scrollView.add(label);
scrollView.add(createSeparator());

var labelAuto = TiTTTAttributedLabel.createLabel({
   text: text,
   width: Ti.UI.FILL,
   height: Ti.UI.SIZE,
   textCheckingTypes: TiTTTAttributedLabel.CHECKING_TYPE_LINK|TiTTTAttributedLabel.CHECKING_TYPE_ADDRESS|TiTTTAttributedLabel.CHECKING_TYPE_PHONE_NUMBER
});

scrollView.add(labelAuto);
scrollView.add(createSeparator());

var labelAuto = TiTTTAttributedLabel.createLabel({
   text: text,
   width: Ti.UI.FILL,
   height: Ti.UI.SIZE 
});

scrollView.add(labelAuto);
scrollView.add(createSeparator());

var label = TiTTTAttributedLabel.createLabel({
   text: "Lorem ipsum dolor amet (3)",
   width: Ti.UI.FILL,
   height: "20dp"
});

scrollView.add(label);

win.open();

