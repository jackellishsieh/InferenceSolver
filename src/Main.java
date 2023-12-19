import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Iterator;

import jess.JessException;
import jess.Rete;

/*
 * File for executing Jess code and engine
 */
public class Main {

	public static String setupFilename = "src/setup.clp";
	
	public static void main(String[] args) {

		try {
			// Create a new engine
			Rete engine = new Rete();

			// Read the file as a string
			String fileContents = null;
			Path path = Path.of("src/setup.clp");
			try {
				 fileContents = Files.readString(path);
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			// Print the file contents
//			System.out.println(fileContents);
			
			// Evaluate the file contents
			engine.eval(fileContents);
			
			// Print all facts
			Iterator iterator = engine.listFacts();
			
			System.out.println("\n\nPRINTING FACTS!!!"); 
			while (iterator.hasNext()) {
				System.out.println(iterator.next());
			}
			
			// Clear the engine (does this do anything?)
			engine.clear();

		} catch (JessException ex) {
			System.err.println(ex);
		}

		System.out.println("\n\nGoodbye world!");
	}
	
//	double mean = 5;
//	double stdev = 4;
//	NormalDistribution test = new NormalDistribution(mean, stdev);

//	System.out.println("normcdf(lower = -infinity, upper = 3) = " + test.cumulativeProbability(3));

}
