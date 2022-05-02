# Using Data to Tell Stories About Food 
Current web app is published [here](https://0bexj0-grace-campidilli.shinyapps.io/wfp_data_app/).  <br/>
### Project Overview
This tool allows students to explore different ways to present their research. By combining data analysis and visualization of FAO data with excerpts of the student's research paper, this tool gives the students the opportunity to transform the paper they wrote for NYYI into a data-driven magazine. This tool was introduced to the 50 NYYI participants during a workshop at the day-long NYYI event on March 25, 2022.

The website could be thought of as a combination of a google form and data dashboard. It is designed to capture the key ideas the user’s research paper focuses on. The user interface asks basic questions about the user’s research, including ‘what country does your research focus on?’ and ‘what is the key challenge your research focuses on?’. The interface also asks the user to input 2-3 sentence quotes from their paper about their topic and proposed solutions. Based on these inputs, the website utilizes FAO data to produce data visualization and summary statistics.

Then, with the click of the ‘finished’ button, all of the information on the webpage is placed at predetermined locations on the magazine template, and the magazine pdf is becomes available to download. Because this project is still in its beginning stages, this last part is not perfectly automated - sometimes text is not formatted 100% correctly on the template. When this happens, I am able to manually edit the arrangement of information on the magazine using a basic pdf viewer. I am actively working on improving this feature. <br/>
### Table of Contents<br/>
'app.R' defines the user interface and the defines the server<br/>
'outputToTemplate.py' takes the output of the webapp and arranges it on the magazine template<br/>
'example_magazine_product.pdf' from a student that participated in the workshop <br/>
'RData_objects' contains rda files of all FAO data used in the app<br/>
'www' contains all other scripts and objects used in the web app<br/>

