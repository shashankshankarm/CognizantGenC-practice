public class Logger {
    // Declare a private static reference for the singleton instance
    private static Logger singleInstance;

    // Private constructor to prevent direct instantiation
    private Logger() {
        System.out.println("Logger instance has been initialized.");
    }

    // Public method to provide access to the singleton instance
    public static Logger getInstance() {
        if (singleInstance == null) {
            singleInstance = new Logger();
        }
        return singleInstance;
    }

    // Method to display log messages
    public void log(String message) {
        System.out.println("Message Logged: " + message);
    }
}
