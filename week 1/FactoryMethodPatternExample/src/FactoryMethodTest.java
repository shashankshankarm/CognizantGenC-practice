public class FactoryMethodTest {
    public static void main(String[] args) {
        // Create factory for Word document
        DocumentFactory wordDocFactory = new WordDocumentFactory();
        Document wordDocument = wordDocFactory.createDocument();
        wordDocument.open();

        // Create factory for PDF document
        DocumentFactory pdfDocFactory = new PdfDocumentFactory();
        Document pdfDocument = pdfDocFactory.createDocument();
        pdfDocument.open();

        // Create factory for Excel document
        DocumentFactory excelDocFactory = new ExcelDocumentFactory();
        Document excelDocument = excelDocFactory.createDocument();
        excelDocument.open();
    }
}
