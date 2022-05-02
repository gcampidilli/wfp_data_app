#!/usr/bin/env python3

from reportlab.pdfgen import canvas
from PyPDF2 import PdfFileWriter, PdfFileReader

# load in line
name = open('sample_output/student_intro.txt','r').readlines()[0]
# remove '\n' char
name = name[0:len(name)-1]
school= open('sample_output/student_intro.txt','r').readlines()[1]
school = school[0:len(school)-1]
grade = open('sample_output/student_intro.txt','r').readlines()[2]
grade = grade[0:len(grade)-1]
country = open('sample_output/student_intro.txt','r').readlines()[3]
country = country[0:len(country)-1]
category = open('sample_output/student_intro.txt','r').readlines()[4]
category = category[0:len(category)-1]
paperTitle = open('sample_output/student_intro.txt','r').readlines()[5]
paperTitle = paperTitle[0:len(paperTitle)-1]
paperChallenge = open('sample_output/student_intro.txt','r').readlines()[6]
paperChallenge = paperChallenge[0:len(paperChallenge)-1]
paperSolution = open('sample_output/student_intro.txt','r').readlines()[7]
paperSolution = paperSolution[0:len(paperSolution)-1]
paperSummary = open('sample_output/student_intro.txt','r').readlines()[8]
paperSummary = paperSummary[0:len(paperSummary)-1]
percentUrban = open('sample_output/student_intro.txt','r').readlines()[9]
percentUrban = percentUrban[0:len(percentUrban)-1]
percentRural = open('sample_output/student_intro.txt','r').readlines()[10]
percentRural = percentRural[0:len(percentRural)-1]
#typical household
#topCrops, parse by ')'
paperChallengeLong = open('sample_output/student_intro.txt','r').readlines()[13]
paperChallengeLong = paperChallengeLong[0:len(paperChallengeLong)-1]
paperSolutionLong = open('sample_output/student_intro.txt','r').readlines()[14]
paperSolutionLong = paperSolutionLong[0:len(paperSolutionLong)-1]
worksCited = open('sample_output/student_intro.txt','r').readlines()[15]
worksCited = worksCited[0:len(worksCited)-1]

def cmtopx(centi):
  pixels = ( 72 * centi)/2.54
  return(round(pixels, 2))

c = canvas.Canvas('c1.pdf')

# MAX 4 lines, 15 char each
# manually code text wrapping
# string split at last space
# get length of str at index 0 in resulting array
# check if next char in original string is a space, if that is the case then remove
# remove that length from original string
# repeat until original string is < maxChar

def textWrap(origString, maxChar, lineSpace, xCord, topYCord):
    i = 1
    while len(origString) > 0:
          if(len(origString)<maxChar):
              if(len(origString)==0):
                  break
              else:
                  c.drawString(cmtopx(xCord), cmtopx(29.7-(topYCord+(lineSpace*i))), origString)
                  break
          else:
              tmp = origString[0:maxChar-1].rsplit(' ',1)
              c.drawString(cmtopx(xCord), cmtopx(29.7-(topYCord+(lineSpace*i))), tmp[0])
              if(origString[len(tmp[0])].isspace()):
                  origString = origString[len(tmp[0])+1:len(origString)]
              else:
                  origString = origString[len(tmp[0]):len(origString)]
              i = i + 1

# P1 PAPER TITLE
c.setFont('Helvetica-Bold', 45)
c.setFillColorRGB(255,255,255)
maxChar = 16
titleLineSpace = (18.7-8.9)/5
textWrap(paperTitle, 16, titleLineSpace, 3.4, 8.9)

# P1 AUTHOR NAME
c.setFont('Helvetica-Bold', 30)
c.drawRightString(cmtopx(21-3.7), cmtopx(29.7-21), name)

c.showPage()

# P2 AUTHOR NAME
c.setFont('Helvetica-Bold', 20)
c.drawString(cmtopx(2.1), cmtopx(29.7-4.25), name)
# P2 AUTHOR SCHOOL, HOMETOWN, GRADE
c.drawString(cmtopx(2.1), cmtopx(29.7-5), school)
c.drawString(cmtopx(2.1), cmtopx(29.7-5.75), grade)
#
# IMPLEMENT: P2 AUTHOR HEADSHOT
#
c.showPage()

# P3 country
c.setFont('Helvetica-Bold', 30)
c.drawString(cmtopx(2.5), cmtopx(29.7-5), country)
# P3 KEY CHALLENGE
challengeLineSpace = 1.25
textWrap(paperChallenge, 30, challengeLineSpace, 2.5, 7.6)
# P3 PROPOSED SOLUTION
solutionLineSpace = 1.25
textWrap(paperSolution, 30, solutionLineSpace, 2.5, 12.9)
# P3 paperSummary
c.setFont('Helvetica-Bold', 20)
textWrap(paperSummary, 40, 0.85, 2.5, 18)

c.showPage()

# P4 country
if(len(country) < 7):
    c.setFont('Helvetica-Bold', 100)
    c.drawString(cmtopx(2.1), cmtopx(29.7-4.5), country)
elif(7 < len(country) < 12):
    c.setFont('Helvetica-Bold', 60)
    c.drawString(cmtopx(2.1), cmtopx(29.7-3.5), country)
elif(len(country) > 12):
    c.setFont('Helvetica-Bold', 60)
    textWrap(country, 12, 1.85, 2.1, 3.5)


#
# IMPLEMENT: P4 COUNTRY IMAGE
#

c.showPage()

# P5 POPULATION GRAPH
# c.drawImage('./www/sample_output/pop_total.png',cmtopx(2.1), cmtopx(2.1), width = cmtopx(16.8), height = cmtopx(11.5))
c.drawImage('./sample_output/pop_total.png',cmtopx(2.1), cmtopx(29.7-11.5), width = cmtopx(16.8), height = cmtopx(10))
# P5 PERCENT URBAN
c.setFont('Helvetica-Bold', 30)
#c.setFillColorRGB(2,83,115)
c.drawString(cmtopx(10.5),cmtopx(29.7-14.2), percentUrban)
# P5 PERCENT RURAL
c.setFont('Helvetica-Bold', 30)
c.drawString(cmtopx(10.5),cmtopx(29.7-15.7), percentRural)
#
# IMPLEMENT: P5 HOUSEHOLD
#

c.showPage()

# P6 COUNTRY
c.setFont('Helvetica-Bold', 30)
c.setFillColorRGB(0,0,0)
c.drawString(cmtopx(3.4), cmtopx(29.7-3.95), country)
# P6 LAND COVER
# c.drawImage('./www/sample_output/land_cover.png',cmtopx(4.6), cmtopx(29.7-4.6), width = cmtopx(12.6), height = cmtopx(11.1))
c.drawImage('./sample_output/land_cover.png',cmtopx(4.6), cmtopx(29.7-16.25), width = cmtopx(12.6), height = cmtopx(11.1), mask = 'auto')
#
# IMPLEMENT: P6 TOP 5 CROPS
#

c.showPage()

# P7 KEY CHALLENGE - short
c.setFont('Helvetica-Bold', 30)
challengeLineSpace = 1.1
textWrap(paperChallenge, 30, challengeLineSpace, 2.1, 3)
# P7 KEY challenge - quote
c.setFont('Helvetica', 20)
c.setFillColorRGB(255,255,255)
quoteChallengeLS = (22.8-6.6)/17
textWrap(paperChallengeLong, 45, quoteChallengeLS, 3.2, 6.8)

c.showPage()

# P8 PROPOSED SOLUTION - short
c.setFont('Helvetica-Bold', 30)
c.setFillColorRGB(0,0,0)
solutionLineSpace = 1.1
textWrap(paperSolution, 30, challengeLineSpace, 2.1, 3)
# P8 PROPOSED SOLUTION - quote
c.setFont('Helvetica', 20)
quoteSolutionLS = (20.1-6.3)/14
textWrap(paperSolutionLong, 45, quoteSolutionLS, 3.2, 6.5)

c.showPage()

# P9 WORKS CITED
c.setFont('Helvetica', 12)
c.setFillColorRGB(0,0,0)
worksCitedLS = (27.6-15.4)/28
textWrap(worksCited, 75, quoteSolutionLS, 2.1, 15.4)


c.save()


# Get the watermark file you just created
cUpload = PdfFileReader(open("c1.pdf", "rb"))
# Get our files ready
output_file = PdfFileWriter()
input_file = PdfFileReader(open("./BLANK_wfp_template.pdf", "rb"))

# get page object
input_p1 = input_file.getPage(0)
# overlay image onto template
input_p1.mergePage(cUpload.getPage(0))
# add page from input file to output document
output_file.addPage(input_p1)

# get page object
input_p2 = input_file.getPage(1)
# overlay image onto template
input_p2.mergePage(cUpload.getPage(1))
# add page from input file to output document
output_file.addPage(input_p2)

# get page object
input_p3 = input_file.getPage(2)
# overlay image onto template
input_p3.mergePage(cUpload.getPage(2))
# add page from input file to output document
output_file.addPage(input_p3)

input_p4 = input_file.getPage(3)
# overlay image onto template
input_p4.mergePage(cUpload.getPage(3))
# add page from input file to output document
output_file.addPage(input_p4)

input_p5 = input_file.getPage(4)
# overlay image onto template
input_p5.mergePage(cUpload.getPage(4))
# add page from input file to output document
output_file.addPage(input_p5)

input_p6 = input_file.getPage(5)
# overlay image onto template
input_p6.mergePage(cUpload.getPage(5))
# add page from input file to output document
output_file.addPage(input_p6)

input_p7 = input_file.getPage(6)
# overlay image onto template
input_p7.mergePage(cUpload.getPage(6))
# add page from input file to output document
output_file.addPage(input_p7)

input_p8 = input_file.getPage(7)
# overlay image onto template
input_p8.mergePage(cUpload.getPage(7))
# add page from input file to output document
output_file.addPage(input_p8)

input_p9 = input_file.getPage(8)
# overlay image onto template
input_p9.mergePage(cUpload.getPage(8))
# add page from input file to output document
output_file.addPage(input_p9)

# finally, write "output" to document-output.pdf
with open("out5.pdf", "wb") as outputStream:
  output_file.write(outputStream)
