import java.util.Scanner;
import java.io.FileReader;

class Configuration {
    public static final double ONE_GIGABYTE = 9.5367431640625e-7;
    public static final String MEM_PATH = "/proc/meminfo";
    public static final String MEM_TOTAL_KEY = "MemTotal:";
    public static final String MEM_AVAILABLE_KEY = "MemAvailable:";
    public static final String BAT_PATH = "/sys/class/power_supply/BAT0/uevent";
    public static final String BAT_CAPACITY_KEY = "POWER_SUPPLY_CAPACITY";
    public static final String BAT_STATUS_KEY = "POWER_SUPPLY_STATUS";
}

class PanelInfo {
    public static double GiB(int value_kb) {
	return (double) value_kb * Configuration.ONE_GIGABYTE;
    } 
    
    public static String memory() throws Exception {
	Scanner in = new Scanner(new FileReader(Configuration.MEM_PATH));

	int available = 0, total = 0, found = 0;
	
	while (in.hasNext()) {
	    if (found > 1)
		break;
	    
	    if (in.next().equals(Configuration.MEM_TOTAL_KEY)) {
		total = Integer.parseInt(in.next());
		found += 1;
	    }
	    if (in.next().equals(Configuration.MEM_AVAILABLE_KEY)) {
		available = Integer.parseInt(in.next());
		found += 1;
	    }
	}
	
	return String.format("%.2fGi / %.2fGi", GiB(total) - GiB(available), GiB(total));
    }

    public static String battery() throws Exception {
	Scanner in = new Scanner(new FileReader(Configuration.BAT_PATH));

	int capacity = 0, found = 0;
	char status = '\0';

	String[] line;

	while (in.hasNext()) {
	    if (found > 1)
		break;

	    line = in.next().split("=");
	    
	    if (line[0].equals(Configuration.BAT_CAPACITY_KEY)) {
		capacity = Integer.parseInt(line[1]);
		found += 1;
	    }
	    if (line[0].equals(Configuration.BAT_STATUS_KEY)) {
		if (line[1].equals("Charging"))
		    status = '^';
		found += 1;
	    }
	}

	return String.format("%s%c", capacity, status);
    }
    
    public static void main(String[] args) throws Exception {
	for (;;) {
	    System.out.println(String.format("%s | %s", memory(), battery()));

	    Thread.sleep(1000);
	}
    }
}
