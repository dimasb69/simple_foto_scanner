<h2 align="center"> {MomDontGo.Dev} -- Projects  | Simple Foto Scanner </h2>

<h1 align="center"> Una aplicación simple para escanear</h1>
<h1 align="center"> Ya sea foto de un documentos o una imagen y hacer Corp</h1>
<h1 align="center"> Guardar un PDF de varias paginas ó un solo JPG</h1>

<br>
	Esta creado pensando en dar una herramienta util y sencilla para el día a día!! sin complicar mucho con funciones rebuscadas, simplemente que tomes tu teléfono abrir la App, escojas tu opción y listo toma la foto o las fotos que necesitas, ya sea de la cámara o de la galería!. De momento se anexa 1 a 1 en un futuro se implementara esa opción!
<br>

<h1 align="center"> En la importacion del document scanner (donde se llama el metodo: DocumentScannerFlutter), existe una sub libreria de pdf_generator_gallery(donde se llama la a PdfGeneratotGallery) dentro esta funcion de onDone() la cual se modifica para que la imagen este mas acorde al tamaño de la hoja y con menos margen! 
tambien se agrego la importacion de import 'package:pdf/pdf.dart'; para poder usar PdfPageFormat y el margin	
anexo el codigo modificado!</h1>

<h1 align="center"> onDone() async {
			final pdf = pw.Document();
			for (var file in files) {
				pdf.addPage(pw.Page(pageFormat: PdfPageFormat.a4,
				margin: pw.EdgeInsets.all(10),
				build: (pw.Context context) {
					return pw.ConstrainedBox(
					  constraints: pw.BoxConstraints.expand(),
					  child: pw.FittedBox(
						fit: pw.BoxFit.fill,
							child: pw.Image(
								pw.MemoryImage(
								file.readAsBytesSync(),
								),
							),
					  )
					);
				})
				);
			}
		}		
</h1>
