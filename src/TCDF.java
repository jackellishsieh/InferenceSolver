import org.apache.commons.math3.distribution.TDistribution;

import jess.Context;
import jess.JessException;
import jess.RU;
import jess.Userfunction;
import jess.Value;
import jess.ValueVector;

public class TCDF implements Userfunction {
	
	/*
	 * Accepts the upper bound
	 * Set with mean = 0, stdev = 1
	 * Returns normalCdf(lower=-inf, upper=upper)
	 */
	@Override
	public Value call(ValueVector valueVector, Context context) throws JessException {
		double upperBound = valueVector.get(1).floatValue(context);
		double degreesOfFreedom = valueVector.get(2).floatValue(context);
		
		TDistribution tDistribution = new TDistribution(degreesOfFreedom);

		return new Value(tDistribution.cumulativeProbability(upperBound), RU.FLOAT);
	}

	@Override
	public String getName() {
		return "tCDF";
	}

}
