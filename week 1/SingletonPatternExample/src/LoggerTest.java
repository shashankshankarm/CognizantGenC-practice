public class LoggerTest {
    public static void main(String[] args) {
        // Obtain logger instances
        Logger instanceOne = Logger.getInstance();
        Logger instanceTwo = Logger.getInstance();

        // Write a log entry
        instanceOne.log("Logging an example message.");

        // Confirm if both references point to the same logger object
        if (instanceOne == instanceTwo) {
            System.out.println("Logger instances refer to the same object.");
        } else {
            System.out.println("Separate logger objects were created!");
        }
    }
}
