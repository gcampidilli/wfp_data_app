#!/usr/bin/env python3

from reportlab.pdfgen import canvas
from PyPDF2 import PdfFileWriter, PdfFileReader

def convert(name_path):
    # load in line
    name = open(name_path,'r').readlines()[0]
    # remove '\n' char
    name = name[0:len(name)-1]
    school= open(name_path,'r').readlines()[1]
    school = school[0:len(school)-1]
    grade = open(name_path,'r').readlines()[2]
    grade = grade[0:len(grade)-1]
    country = open(name_path,'r').readlines()[3]
    country = country[0:len(country)-1]
    category = open(name_path,'r').readlines()[4]
    category = category[0:len(category)-1]
    paperTitle = open(name_path,'r').readlines()[5]
    paperTitle = paperTitle[0:len(paperTitle)-1]
    paperSummary = open(name_path,'r').readlines()[6]
    paperSummary = paperSummary[0:len(paperSummary)-1]

    def cmtopx(centi):
        pixels = ( 72 * centi)/2.54
        return(round(pixels, 2))

    p1 = canvas.Canvas('p1.pdf')

    # PAPER TITLE
    p1.setFont('Helvetica-Bold', 45)
    p1.setFillColorRGB(255,255,255)
    # MAX 4 lines, 15 char each
    # manually code text wrapping
    # look at first 15 characters
    # string split at last space
    # get length of str at index 0 in resulting array
    # check if next char in original string is a space, if that is the case then remove
    # remove that length from original string
    # repeat until original string is length 0
    origtitle = paperTitle
    maxChar = 16
    i = 1
    lineSpace = (18.7-8.9)/5
    while len(origtitle) > 0:
            if(len(origtitle)<maxChar):
                if(len(origtitle)==0):
                    break
                else:
                    p1.drawString(cmtopx(3.4), cmtopx(29.7-(8.9+(lineSpace*i))), origtitle)
                    break
            else:
                tmp = origtitle[0:maxChar-1].rsplit(' ',1)
                p1.drawString(cmtopx(3.4), cmtopx(29.7-(8.9+(lineSpace*i))), tmp[0])
                if(origtitle[len(tmp[0])].isspace()):
                    origtitle = origtitle[len(tmp[0])+1:len(origtitle)]
                else:
                    origtitle = origtitle[len(tmp[0]):len(origtitle)]
                i = i + 1

    # AUTHOR NAME
    p1.setFont('Helvetica-Bold', 30)
    p1.drawRightString(cmtopx(21-3.7), cmtopx(29.7-21), name)

    p1.showPage()

    p1.drawImage('./www/sample_output/pop_total.png', x = cmtopx(2.1), y = cmtopx(29.7-(2.1+10)), width = cmtopx(21-4.2), height = cmtopx(11))

    p1.save()


    # Get the watermark file you just created
    p1Upload = PdfFileReader(open("p1.pdf", "rb"))
    # Get our files ready
    output_file = PdfFileWriter()
    input_file = PdfFileReader(open("./www/subset_wfp_template.pdf", "rb"))

    # get page object
    input_p1 = input_file.getPage(0)
    # overlay image onto template
    input_p1.mergePage(p1Upload.getPage(0))
    # add page from input file to output document
    output_file.addPage(input_p1)

    # get page object
    input_p1 = input_file.getPage(1)
    # overlay image onto template
    input_p1.mergePage(p1Upload.getPage(1))
    # add page from input file to output document
    output_file.addPage(input_p1)

    # finally, write "output" to document-output.pdf
    with open("out3.pdf", "wb") as outputStream:
        output_file.write(outputStream)

    return None
