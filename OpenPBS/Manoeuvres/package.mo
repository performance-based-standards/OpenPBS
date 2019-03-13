within OpenPBS;
package Manoeuvres










  annotation (Documentation(info="<html>
<p><u><b>Manoeuvres</b></u> contains models where the vehicle models from the previously described package is instantiated. Manoeuvres parameters and equations are added as well as calculations of the PBS measures (each one only represented by a Modelica variable, named as the PBS&rsquo;s name in Table 1) that can be found from the manoeuvre. A registry from the first described package is included in each manoeuvre model, so that the vehicle parameters can be set for instances of the manoeuvre model. Note that the manouvre models are complete and can be simulated in the Modelica tool or exported as FMUs for simulation in an arbitrary platform. </p>
<h5>Table 1: The set of PBSes from project &ldquo;Performance Based Standards for High Capacity Transports in Sweden&rdquo; (FFI project, Vinnova reference number 2013-03881). </h5>
<table cellspacing=\"2\" cellpadding=\"0\" border=\"0\"><tr>
<td rowspan=\"3\" style=\"background-color: #c7c7c7\"><h4><span style=\"background-color: #c7c7c7\">Main motivation</span></h4></td>
<td colspan=\"2\" style=\"background-color: #c7c7c7\"><h4><span style=\"background-color: #c7c7c7\">PBS measure</span></h4></td>
<td colspan=\"2\" style=\"background-color: #c7c7c7\"><h4><span style=\"background-color: #c7c7c7\">Short, approximate definition.</span></h4></td>
<td rowspan=\"3\" style=\"background-color: #c7c7c7\"><h4><span style=\"background-color: #c7c7c7\">Typical requirement</span></h4></td>
<td rowspan=\"3\" style=\"background-color: #c7c7c7\"><h4><span style=\"background-color: #c7c7c7\">Manouvre name in tool</span></h4></td>
</tr>
<tr>
<td rowspan=\"2\" style=\"background-color: #c7c7c7\"><h4><span style=\"background-color: #c7c7c7\">Name</span></h4></td>
<td rowspan=\"2\" style=\"background-color: #c7c7c7\"><h4><span style=\"background-color: #c7c7c7\">Abb-revia­</span></h4><p><span style=\"background-color: #c7c7c7;\">tion</span></p></td>
<td colspan=\"2\" style=\"background-color: #c7c7c7\"><h4><span style=\"background-color: #c7c7c7\">If not else stated: Max cargo weight, Cargo uniformly distributed, Flat road, Road friction 0.8.</span></h4></td>
</tr>
<tr>
<td style=\"background-color: #c7c7c7\"><h4><span style=\"background-color: #c7c7c7\">Measure</span></h4></td>
<td style=\"background-color: #c7c7c7\"><h4><span style=\"background-color: #c7c7c7\">Manoeuvre</span></h4></td>
</tr>
<tr>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Transport efficiency</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Startability</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">SA</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Uphill grade</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Vehicle start from 0 to slow forward. Road friction 0.35.</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">SA=dz/dx&gt;0.12 [m/m]</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Longitudinal</span></p></td>
</tr>
<tr>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Transport efficiency</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Gradeability</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">GA</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Uphill grade</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Vehicle drive in 70 km/h</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">GA=dz/dx&gt;0.01 [m/m]</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Longitudinal</span></p></td>
</tr>
<tr>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Transport efficiency</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Acceleration Capability</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">AC</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Time</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Vehicle accelerates from 0 to 80 km/h</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">AC=t&lt;# [s]</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Longitudinal</span></p></td>
</tr>
<tr>
<td rowspan=\"2\" style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Safety</span></p></td>
<td rowspan=\"2\" style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Braking Stability in a Turn</span></p></td>
<td rowspan=\"2\" style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">BST</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">EBS on all units</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">EBS on all units.</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">BST=TRUE [bool]</span></p></td>
<td rowspan=\"2\" style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">&lt;Not implemented&gt;</span></p></td>
</tr>
<tr>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Brake performance within lane in curve</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Alternative: Brake to 0 km/h when entering #200 m inner radius curve with 80 km/h. Front axle on curve, maximum lateral deviation of other parts #4 m. Road friction #0.35.</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">BST&lt;# [m]</span></p></td>
</tr>
<tr>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Transport efficiency</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Low Speed Swept Path</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">LSSP</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Path width between wheels outer edges</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Low speed 90 deg turn with 12.5 m radius path for outer edge of first unit body</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">LSSP&lt;8.5 [m]</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">LowSpeed</span></p><p><span style=\"background-color: #c7c7c7;\">Curve</span></p></td>
</tr>
<tr>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Transport efficiency</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Frontal Swing</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">FS</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">First unit front body reaching distance outside defined path</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Low speed 90 deg turn with 12.5 m radius path for outer edge of outer front tyre</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">FS&lt;8,5 [m]</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">LowSpeed</span></p><p><span style=\"background-color: #c7c7c7;\">Curve</span></p></td>
</tr>
<tr>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Transport efficiency</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Tail Swing</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">TS</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Last unit rear body reaching distance outside defined path</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Low speed 90 deg turn with 12.5 m radius path for outer edge of outer front tyre</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">TS&lt;8.5 [m]</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">LowSpeed</span></p><p><span style=\"background-color: #c7c7c7;\">Curve</span></p></td>
</tr>
<tr>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Transport efficiency</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Friction demand on Drive Tyres</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">FDDT</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">#Force in ground plane under driven axles</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Low speed 90 deg turn with 12.5 m radius path for outer edge of first unit body</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">FDDT&lt;0.25*GCW [N]???</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">LowSpeed</span></p><p><span style=\"background-color: #c7c7c7;\">Curve</span></p><p><span style=\"background-color: #c7c7c7;\">_Saturated</span></p><p><span style=\"background-color: #c7c7c7;\">Tyre</span></p></td>
</tr>
<tr>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Transport efficiency</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Friction demand on Steering Tyres</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">FDST</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">#Force in ground plane under steered axles</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Low speed 90 deg turn with 12.5 m radius path for outer edge of first unit body</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">FDST&lt;0.2*GCW [N]???</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">LowSpeed</span></p><p><span style=\"background-color: #c7c7c7;\">Curve</span></p><p><span style=\"background-color: #c7c7c7;\">_Saturated</span></p><p><span style=\"background-color: #c7c7c7;\">Tyre</span></p></td>
</tr>
<tr>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Transport efficiency</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Tracking Ability on a Straight Path</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">TASP</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Off-tracking between first and last axle</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Constant speed on straight road with constant cross-fall of #5 deg. Road friction #0.35.</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">TASP&lt;0.4 [m]</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">HighSpeed</span></p><p><span style=\"background-color: #c7c7c7;\">StraightPath</span></p></td>
</tr>
<tr>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Safety</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">High Speed Steady State Off Tracking</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">HSSO</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Off-tracking between first and last axle</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Steady state cornering at radius #100 m and lateral acceleration 3.5&nbsp; m/(s*s)</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">HSSO&lt;# [m]</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">HighSpeed</span></p><p><span style=\"background-color: #c7c7c7;\">Curve</span></p></td>
</tr>
<tr>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Safety, roll-over</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Steady state Rollover Threshold</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">SRT</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Lateral acceleration</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Steady state cornering at radius #100 m. Slowly increasing longitudinal speed until all inner wheels on one roll-stiff unit has lifted.</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">SRT&gt;3.5 [m/(s*s)]</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">&lt;Not </span></p><p><span style=\"background-color: #c7c7c7;\">implemented&gt;</span></p></td>
</tr>
<tr>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Safety</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Yaw Damping</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">YD</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Yaw Angle damping over oscillations on worst unit</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Single lane change in 80 km/h as in ISO14791, amplitude lateral acceleration on first axle #2 m/(s*s).</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><br><br><span style=\"background-color: #c7c7c7;\"></p><p><br><br><img src=\"file:///C:\\Users\\bengtja\\AppData\\Local\\Temp\\msohtmlclip1\\01\\clip_image002.png\"/></span></p></td>
<td style=\"background-color: #c7c7c7\"><p><br><br><span style=\"background-color: #c7c7c7;\"></p><p><br><br>SingleLane</span></p><p><br><br><span style=\"background-color: #c7c7c7;\"></p><p><br><br>Change</span></p></td>
</tr>
<tr>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Safety</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">High Speed Transient Off Tracking</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">HSTO</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Off-tracking between first and last axle in ISO lane change</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Single lane change in 80 km/h as in ISO14791, amplitude lateral acceleration on first axle #2 m/(s*s).</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">HSTO&lt;0.8 [m]</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">SingleLane</span></p><p><span style=\"background-color: #c7c7c7;\">Change</span></p></td>
</tr>
<tr>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Safety, roll-over</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Load Transfer Ratio</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">LTR</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Off-tracking between first and last axle</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Single lane change in 80 km/h as in ISO14791, amplitude lateral acceleration on first axle #2 m/(s*s).</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">LTR&lt;# [N/N]</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">SingleLane</span></p><p><span style=\"background-color: #c7c7c7;\">Change</span></p></td>
</tr>
<tr>
<td rowspan=\"2\" style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Safety, yaw stability</span></p></td>
<td rowspan=\"2\" style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Rearward Amplification</span></p></td>
<td rowspan=\"2\" style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">RWA</span></p></td>
<td rowspan=\"2\" style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Yaw Velocity amplification from first to last unit</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Single lane change in 80 km/h as in ISO14791, amplitude lateral acceleration on first axle #2 m/(s*s).</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">RA&lt;2.4 [(rad/s)/(rad/s)]</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">SingleSine</span></p><p><span style=\"background-color: #c7c7c7;\">Steering</span></p></td>
</tr>
<tr>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">Alternative: ISO14791 random steering. Worst ampification</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">RA&lt;# [(rad/s)/(rad/s)]</span></p></td>
<td style=\"background-color: #c7c7c7\"><p><span style=\"background-color: #c7c7c7;\">&lt;Not </span></p><p><span style=\"background-color: #c7c7c7;\">implemented&gt;</span></p></td>
</tr>
</table>
</html>"));
end Manoeuvres;
