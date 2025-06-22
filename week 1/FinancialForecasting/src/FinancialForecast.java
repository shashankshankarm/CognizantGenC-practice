public class FinancialForecast {

    // Recursive function to compute future value
    public static double futureValue(double amountNow, double rate, int yearsRemaining) {
        // Base case: return amount when no years remain
        if (yearsRemaining == 0) {
            return amountNow;
        }
        // Recursive step: multiply by (1 + rate) and decrement years
        return futureValue(amountNow * (1 + rate), rate, yearsRemaining - 1);
    }

    public static void main(String[] args) {
        double currentAmount = 1000.0;
        double growthPerYear = 0.05;
        int totalYears = 10;

        double result = futureValue(currentAmount, growthPerYear, totalYears);
        System.out.printf("Predicted future value after %d years: %.2f\n", totalYears, result);
    }
}
