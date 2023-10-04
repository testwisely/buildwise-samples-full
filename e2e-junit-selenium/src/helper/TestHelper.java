package helper;

public class TestHelper {

    private static String OS = System.getProperty("os.name").toLowerCase();

    public static boolean isWindows() {
        return OS.contains("win");
    }

    public static boolean isMac() {
        return OS.contains("mac");
    }

    public static boolean isUnix() {
        return (OS.contains("nix") || OS.contains("nux")  || OS.contains("aix") );
    }

    public static String siteUrl() {
      return "https://travel.agileway.net";
    }
    
    public static String tempDir() {
        if (isWindows()) {
            return "C:\\temp";
        } else if (isMac()) {
            return "/tmp";
        } else if (isUnix()) {
            return "/tmp";
        } else {
            throw new RuntimeException("Your OS is not support!!");
        }
    }
    
}
