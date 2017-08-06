within OpenPBS;
package VehicleModels 




















annotation (Documentation(info="<html>
<p><span style=\"font-family: Times New Roman; font-size: 7pt;\"> </span><u><b>VehicleModels</b></u> contains models which defines vehicle models in terms of equations, such as equations of motion. A registry from the previously described package is included in each vehicle model, so that the equations can use the vehicle parameters defined there and the vehicle parameters can be set for instances of the vehicle model. Note that no manoeuvre is defined so far. </p>
<h5>Table 1: The set of PBSes from project &quot;Performance Based Standards for High Capacity Transports in Sweden&quot; (FFI project, Vinnova reference number 2013-03881). </h5>
<table cellspacing=\"2\" cellpadding=\"0\" border=\"0\"><tr>
<td rowspan=\"3\" style=\"background-color: #e6e6e6\"><h4><span style=\"background-color: #e6e6e6\">Main motivation</span></h4></td>
<td colspan=\"2\" style=\"background-color: #e6e6e6\"><h4><span style=\"background-color: #e6e6e6\">PBS measure</span></h4></td>
<td colspan=\"2\" style=\"background-color: #e6e6e6\"><h4><span style=\"background-color: #e6e6e6\">Short, approximate definition.</span></h4></td>
<td rowspan=\"3\" style=\"background-color: #e6e6e6\"><h4><span style=\"background-color: #e6e6e6\">Typical requirement</span></h4></td>
<td rowspan=\"3\" style=\"background-color: #e6e6e6\"><h4><span style=\"background-color: #e6e6e6\">Manouvre name in tool</span></h4></td>
</tr>
<tr>
<td rowspan=\"2\" style=\"background-color: #e6e6e6\"><h4><span style=\"background-color: #e6e6e6\">Name</span></h4></td>
<td rowspan=\"2\" style=\"background-color: #e6e6e6\"><p><h4><span style=\"background-color: #e6e6e6\">Abb-revia­</p><p>tion</span></h4></p></td>
<td colspan=\"2\" style=\"background-color: #e6e6e6\"><h4><span style=\"background-color: #e6e6e6\">If not else stated: Max cargo weight, Cargo uniformly distributed, Flat road, Road friction 0.8.</span></h4></td>
</tr>
<tr>
<td style=\"background-color: #e6e6e6\"><h4><span style=\"background-color: #e6e6e6\">Measure</span></h4></td>
<td style=\"background-color: #e6e6e6\"><h4><span style=\"background-color: #e6e6e6\">Manoeuvre</span></h4></td>
</tr>
<tr>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Transport efficiency</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Startability</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">SA</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Uphill grade</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Vehicle start from 0 to slow forward. Road friction 0.35.</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">SA=dz/dx&gt;0.12 [m/m]</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Longitudinal</span></p></td>
</tr>
<tr>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Transport efficiency</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Gradeability</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">GA</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Uphill grade</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Vehicle drive in 70 km/h</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">GA=dz/dx&gt;0.01 [m/m]</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Longitudinal</span></p></td>
</tr>
<tr>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Transport efficiency</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Acceleration Capability</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">AC</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Time</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Vehicle accelerates from 0 to 80 km/h</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">AC=t&lt;# [s]</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Longitudinal</span></p></td>
</tr>
<tr>
<td rowspan=\"2\" style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Safety</span></p></td>
<td rowspan=\"2\" style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Braking Stability in a Turn</span></p></td>
<td rowspan=\"2\" style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">BST</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">EBS on all units</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">EBS on all units.</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">BST=TRUE [bool]</span></p></td>
<td rowspan=\"2\" style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">&lt;Not implemented&gt;</span></p></td>
</tr>
<tr>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Brake performance within lane in curve</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Alternative: Brake to 0 km/h when entering #200 m inner radius curve with 80 km/h. Front axle on curve, maximum lateral deviation of other parts #4 m. Road friction #0.35.</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">BST&lt;# [m]</span></p></td>
</tr>
<tr>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Transport efficiency</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Low Speed Swept Path</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">LSSP</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Path width between wheels outer edges</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Low speed 90 deg turn with 12.5 m radius path for outer edge of first unit body</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">LSSP&lt;8.5 [m]</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">LowSpeed</p><p>Curve</span></p></td>
</tr>
<tr>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Transport efficiency</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Frontal Swing</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">FS</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">First unit front body reaching distance outside defined path</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Low speed 90 deg turn with 12.5 m radius path for outer edge of outer front tyre</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">FS&lt;8,5 [m]</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">LowSpeed</p><p>Curve</span></p></td>
</tr>
<tr>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Transport efficiency</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Tail Swing</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">TS</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Last unit rear body reaching distance outside defined path</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Low speed 90 deg turn with 12.5 m radius path for outer edge of outer front tyre</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">TS&lt;8.5 [m]</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">LowSpeed</p><p>Curve</span></p></td>
</tr>
<tr>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Transport efficiency</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Friction demand on Drive Tyres</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">FDDT</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">#Force in ground plane under driven axles</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Low speed 90 deg turn with 12.5 m radius path for outer edge of first unit body</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">FDDT&lt;0.25*GCW [N]???</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">LowSpeed</p><p>Curve</p><p>_Saturated</p><p>Tyre</span></p></td>
</tr>
<tr>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Transport efficiency</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Friction demand on Steering Tyres</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">FDST</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">#Force in ground plane under steered axles</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Low speed 90 deg turn with 12.5 m radius path for outer edge of first unit body</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">FDST&lt;0.2*GCW [N]???</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">LowSpeed</p><p>Curve</p><p>_Saturated</p><p>Tyre</span></p></td>
</tr>
<tr>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Transport efficiency</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Tracking Ability on a Straight Path</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">TASP</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Off-tracking between first and last axle</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Constant speed on straight road with constant cross-fall of #5 deg. Road friction #0.35.</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">TASP&lt;0.4 [m]</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">HighSpeed</p><p>StraightPath</span></p></td>
</tr>
<tr>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Safety</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">High Speed Steady State Off Tracking</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">HSSO</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Off-tracking between first and last axle</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Steady state cornering at radius #100 m and lateral acceleration 3.5&nbsp; m/(s*s)</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">HSSO&lt;# [m]</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">HighSpeed</p><p>Curve</span></p></td>
</tr>
<tr>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Safety, roll-over</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Steady state Rollover Threshold</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">SRT</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Lateral acceleration</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Steady state cornering at radius #100 m. Slowly increasing longitudinal speed until all inner wheels on one roll-stiff unit has lifted.</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">SRT&gt;3.5 [m/(s*s)]</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">&lt;Not </p><p>implemented&gt;</span></p></td>
</tr>
<tr>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Safety</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Yaw Damping</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">YD</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Yaw Angle damping over oscillations on worst unit</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Single lane change in 80 km/h as in ISO14791, amplitude lateral acceleration on first axle #2 m/(s*s).</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><br><br><br><br><br><span style=\"background-color: #e6e6e6;\"><img src=\"file:///C:\\Users\\bengtja\\AppData\\Local\\Temp\\msohtmlclip1\\01\\clip_image002.png\"/></span></p>
</td>
<td style=\"background-color: #e6e6e6\"><p><br><br><br><br><br><span style=\"background-color: #e6e6e6;\">SingleLane</p><p><br><br><br><br><br>Change</span></p></td>
</tr>
<tr>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Safety</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">High Speed Transient Off Tracking</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">HSTO</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Off-tracking between first and last axle in ISO lane change</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Single lane change in 80 km/h as in ISO14791, amplitude lateral acceleration on first axle #2 m/(s*s).</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">HSTO&lt;0.8 [m]</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">SingleLane</p><p>Change</span></p></td>
</tr>
<tr>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Safety, roll-over</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Load Transfer Ratio</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">LTR</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Off-tracking between first and last axle</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Single lane change in 80 km/h as in ISO14791, amplitude lateral acceleration on first axle #2 m/(s*s).</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">LTR&lt;# [N/N]</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">SingleLane</p><p>Change</span></p></td>
</tr>
<tr>
<td rowspan=\"2\" style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Safety, yaw stability</span></p></td>
<td rowspan=\"2\" style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Rearward Amplification</span></p></td>
<td rowspan=\"2\" style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">RWA</span></p></td>
<td rowspan=\"2\" style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Yaw Velocity amplification from first to last unit</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Single lane change in 80 km/h as in ISO14791, amplitude lateral acceleration on first axle #2 m/(s*s).</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">RA&lt;2.4 [(rad/s)/(rad/s)]</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">SingleSine</p><p>Steering</span></p></td>
</tr>
<tr>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">Alternative: ISO14791 random steering. Worst ampification</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">RA&lt;# [(rad/s)/(rad/s)]</span></p></td>
<td style=\"background-color: #e6e6e6\"><p><span style=\"background-color: #e6e6e6;\">&lt;Not </p><p>implemented&gt;</span></p></td>
</tr>
</table>
</html>"));
end VehicleModels;
