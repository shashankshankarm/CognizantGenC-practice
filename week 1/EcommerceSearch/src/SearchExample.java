import java.util.Arrays;
import java.util.Comparator;

public class SearchExample {

    // Method for linear search by product name
    public static int searchLinear(Product[] items, String searchName) {
        for (int i = 0; i < items.length; i++) {
            if (items[i].productName.equalsIgnoreCase(searchName)) {
                return i;
            }
        }
        return -1;
    }

    // Method for binary search (requires sorted array)
    public static int searchBinary(Product[] items, String searchName) {
        int start = 0;
        int end = items.length - 1;

        while (start <= end) {
            int mid = start + (end - start) / 2;
            int result = items[mid].productName.compareToIgnoreCase(searchName);

            if (result == 0) return mid;
            if (result < 0) start = mid + 1;
            else end = mid - 1;
        }

        return -1;
    }

    public static void main(String[] args) {
        // Initialize product list
        Product[] inventory = {
            new Product(1, "Laptop", "Electronics"),
            new Product(2, "Shoes", "Footwear"),
            new Product(3, "Phone", "Electronics"),
            new Product(4, "Book", "Stationery")
        };

        // Linear search call
        int posLinear = searchLinear(inventory, "Phone");
        System.out.println("Linear Search: Product found at index " + posLinear);

        // Sort array before binary search
        Arrays.sort(inventory, Comparator.comparing(p -> p.productName.toLowerCase()));

        // Binary search call
        int posBinary = searchBinary(inventory, "Phone");
        System.out.println("Binary Search: Product found at index " + posBinary);
    }
}
