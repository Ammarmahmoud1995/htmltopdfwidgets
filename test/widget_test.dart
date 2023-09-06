// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pdf/pdf.dart';

// Function to be tested
List input = ['''<div dir="rtl" style="text-align: left;"><font color="#c437c4" size="5">Ammar mahmoud 1</font></div>''',
'''<div dir="rtl" style="text-align: left;"><font color="#c437c4" size="5"><br></font></div>''',
'''<div dir="rtl" style="text-align: center;"><font size="6">2 عمار محمود&nbsp;</font></div>''',
'''<div dir="rtl" style="text-align: center;"><font size="6"><br></font></div>''',
'''<div dir="rtl" style="text-align: center;"><font color="#583f3e" size="6">3 عمار Mahmoud</font></div>''',
'''<div dir="rtl" style="text-align: right;">4 السلام وعليكم</div>'''
] ;
List expectedValue = [CssProberties(fontsize: 18.0,alignmentfortext: Alignment.centerLeft,selectedcolor:PdfColor(0.7686274509803922, 0.21568627450980393, 0.7686274509803922, 1)),
CssProberties(fontsize: 18.0,alignmentfortext: Alignment.centerLeft,selectedcolor:PdfColor(0.7686274509803922, 0.21568627450980393, 0.7686274509803922, 1) ),
CssProberties(fontsize: 24.0,alignmentfortext: Alignment.center,selectedcolor:null ),
CssProberties(fontsize: 24.0,alignmentfortext: Alignment.center,selectedcolor:null ),
CssProberties(fontsize: 24.0,alignmentfortext: Alignment.center,selectedcolor:PdfColor(0.34509803921568627, 0.24705882352941178, 0.24313725490196078, 1), ),
CssProberties(fontsize: null,alignmentfortext: Alignment.centerRight,selectedcolor:null ),
]  ;
void main() {    
   for(int i = 0 ; i<input.length ; i ++) {
   test("test _handleCss",(){  
      var expected = expectedValue[i];     
  (double?,Alignment?,PdfColor?)  expectedrecord = (expected.fontsize,expected.alignmentfortext,expected.selectedcolor)  ; 
      var actual = _handleCss(input[i]);   
 (double?,Alignment?,PdfColor?)  actualRecord = (actual.fontsize,actual.alignmentfortext,actual.selectedcolor)  ; 
      expect(actualRecord,expectedrecord); 
   }); }
}

CssProberties _handleCss(String outerhtml) { 
CssProberties instance = CssProberties()   ;
if(outerhtml.contains(Css.size)){
  instance.fontsize = Css.fontss[outerhtml.substring(outerhtml.indexOf(Css.size,)+6,outerhtml.indexOf(Css.size,)+7)];
}
if(outerhtml.contains(Css.color)){
  instance.selectedcolor = PdfColor.fromHex(outerhtml.substring(outerhtml.indexOf(Css.color,)+12,outerhtml.indexOf(Css.color,)+19));
}
if(outerhtml.contains(Css.rtl)){
  instance.alignmentfortext = Alignment.centerRight ; 
}else{
   instance.alignmentfortext = Alignment.centerLeft ; 
}
if(outerhtml.contains(Css.alignLeft)){
  instance.alignmentfortext = Alignment.centerLeft ; 
}
else if (outerhtml.contains(Css.alignCenter)){
   instance.alignmentfortext = Alignment.center ; 
}
else if (outerhtml.contains(Css.alignRight)){
   instance.alignmentfortext = Alignment.centerRight ; 
}
  return instance;
} 
class Css{
  static const size = "size=" ; 
  static const color ="font color=" ; 
  static const rtl ="rtl" ; 
  static const alignLeft ="text-align: left;" ; 
  static const alignCenter ="text-align: center;" ; 
  static const alignRight ="text-align: right;" ; 
  static  Map<String,double> fontss = {
  "1" : 8 ,
  "2" : 10 ,
  "3" : 12 ,
  "4" : 14 ,
  "5" : 18 ,
  "6" : 24 ,
  "7" : 36 ,
}    ;
}
class CssProberties {
 double? fontsize;
  PdfColor? selectedcolor;
  Alignment? alignmentfortext;
  CssProberties(
      {this.fontsize,
      this.selectedcolor,
      this.alignmentfortext,
}  )  ;  
}
