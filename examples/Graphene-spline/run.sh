#! /bin/bash

# ======= STEP 1 : Generate force-field grid 

# calculation without DFT electrostatics using atomic charges
python ../../generateLJFF.py -i Gr6x6N3hole.xyz

# ======= STEP 2 : Relax Probe Particle using that force-field grid 

python ../../relaxed_scan.py -k 0.5 -q -0.00 --tipspline TipRSpline.ini
mv Q-0.00K0.50 Q-0.00K0.50-spline
python ../../relaxed_scan.py -k 0.5 -q -0.00

# ======= STEP 3 : Plot the results

cd Q-0.00K0.50
../../../plotZcurves.py -p ../curve_points.ini
cd ..

cd Q-0.00K0.50-spline
../../../plotZcurves.py -p ../curve_points.ini
cd ..

#python ../../plot_results.py -k 0.5 -q -0.00 -a 2.0 --df

echo ""
echo "!!! Now trying the same with saving to npy !!!:"
echo ""


python ../../generateLJFF.py -i Gr6x6N3hole.xyz --npy
python ../../relaxed_scan.py -k 0.2 -q -0.00 --tipspline TipRSpline.ini --npy
mv Q-0.00K0.20 Q-0.00K0.20-spline
python ../../relaxed_scan.py -k 0.2 -q -0.00 --npy
cd Q-0.00K0.20
../../../plotZcurves.py -p ../curve_points.ini --npy
cd ..
cd Q-0.00K0.20-spline
../../../plotZcurves.py -p ../curve_points.ini --npy
cd ..


 