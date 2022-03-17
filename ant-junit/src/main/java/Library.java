import java.util.ArrayList;
import java.util.List;

public class Library {

    private static List<Resource> resources;
    private static List<Member> members;
    private static List<Rental> rentals;

    static {
        resources = new ArrayList<Resource>();
        members = new ArrayList<Member>();
        rentals = new ArrayList<Rental>();
    }
    public static Resource findByTitle(String title) {
        if (title == null || title.isBlank())
            return null;

        for (Resource resource : resources) {
           if (title.equals(resource.getTitle())) {
               return resource;
           }
        }
        return null; // not found
    }

    public static void importResource() {
        resources.add(new Book("Selenium WebDriver Recipes in Ruby"));
    }

    public static int GetResourcesCount() {
        return resources.size();
    }
}
