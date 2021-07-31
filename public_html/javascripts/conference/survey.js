// JavaScript Document
$(document).ready(function(){
$("tr.ratings select").hover
(
function(){
	$(this).parent().append("<span style='font-size:smaller;color:gray' class='highest'> Rate this aspect of Vision2020. '10' is highest. Skip if you did not attend.</span>")},
function(){
	$(this).parent().find("span").empty()
});

$("#attend").hover(
function() {
$(this).parent().append("<span style='font-size:8pt;color:gray' class='highest'> Did you attend alone, with your spouse, or with your family?</span>")},
function(){$(this).parent().find("span").empty()}
);

$("#age0").hover(
function() {
$(this).parent().append("<span style='font-size:8pt;color:gray' class='highest'> How many in your family that attended Vision2020 were under 10 yrs old?</span>")},
function(){$(this).parent().find("span").empty()}
);

$("#age10").hover(
function() {
$(this).parent().append("<span style='font-size:8pt;color:gray' class='highest'> How many in your family that attended Vision2020 were 10-19 yrs old?</span>")},
function(){$(this).parent().find("span").empty()}
);

$("#age20").hover(
function() {
$(this).parent().append("<span style='font-size:8pt;color:gray' class='highest'> How many in your family that attended Vision2020 were 20-something?</span>")},
function(){$(this).parent().find("span").empty()}
);

$("#age30").hover(
function() {
$(this).parent().append("<span style='font-size:8pt;color:gray' class='highest'> How many in your family that attended Vision2020 were 30-something?</span>")},
function(){$(this).parent().find("span").empty()}
);

$("#age40").hover(
function() {
$(this).parent().append("<span style='font-size:8pt;color:gray' class='highest'> How many in your family that attended Vision2020 were 40-something?</span>")},
function(){$(this).parent().find("span").empty()}
);

$("#age50").hover(
function() {
$(this).parent().append("<span style='font-size:8pt;color:gray' class='highest'> How many in your family that attended Vision2020 were 50-something?</span>")},
function(){$(this).parent().find("span").empty()}
);

$("#age60").hover(
function() {
$(this).parent().append("<span style='font-size:8pt;color:gray' class='highest'> How many in your family that attended Vision2020 were 60 plus yrs old?</span>")},
function(){$(this).parent().find("span").empty()}
);

$("#whopaid").hover(
function() {
$(this).parent().append("<span style='font-size:8pt;color:gray' class='highest'> Who paid your way?</span>")},
function(){$(this).parent().find("span").empty()}
);

$("#cost").hover(
function() {
$(this).parent().append("<span style='font-size:8pt;color:gray' class='highest'> How much did it cost?</span>")},
function(){$(this).parent().find("span").empty()}
);

$("#celebrations").hover(
function() {
$(this).parent().append("<span style='font-size:8pt;color:gray' class='highest'> How many of the 8 celebrations did you attend?</span>")},
function(){$(this).parent().find("span").empty()}
);

$("#luncheons").hover(
function() {
$(this).parent().append("<span style='font-size:8pt;color:gray' class='highest'> How many of the 9 sponsored meals did you attend?</span>")},
function(){$(this).parent().find("span").empty()}
);

$("#pray").hover(
function() {
$(this).parent().append("<span style='font-size:8pt;color:gray' class='highest'> Did you pray with your group?</span>")},
function(){$(this).parent().find("span").empty()}
);

$("#spiritual").hover(
function() {
$(this).parent().append("<span style='font-size:8pt;color:gray' class='highest'> Did you have a spiritual conversation?</span>")},
function(){$(this).parent().find("span").empty()}
);

$("#gospel").hover(
function() {
$(this).parent().append("<span style='font-size:8pt;color:gray' class='highest'> Where you able to present the gospel?</span>")},
function(){$(this).parent().find("span").empty()}
);

$("#apply").hover(
function() {
$(this).parent().append("<span style='font-size:8pt;color:gray' class='highest'> Where you able apply Vision2020 passion?</span>")},
function(){$(this).parent().find("span").empty()}
);

$("#churchplanting").hover(
function() {
$(this).parent().prev().append("<span style='font-size:8pt;color:gray' class='highest'> <br/><br/>List church planting plans:</span>")},
function(){$(this).parent().prev().find("span").empty()}
);

$("#leadership").hover(
function() {
$(this).parent().prev().append("<span style='font-size:8pt;color:gray' class='highest'> <br/><br/>Leadership Development plans:</span>")},
function(){$(this).parent().prev().find("span").empty()}
);

$("#integrated").hover(
function() {
$(this).parent().prev().append("<span style='font-size:8pt;color:gray' class='highest'> <br/><br/>List integrated ministry plans:</span>")},
function(){$(this).parent().prev().find("span").empty()}
);

$(".comments").hover(
function() {
$(this).parent().prev().prepend("<p style='font-size:8pt;color:gray;text-align:right' class='highest'> Comment Here:</p>")},
function(){$(this).parent().prev().find("p").empty()}
);

$("#suggestions").hover(
function() {
$(this).parent().prev().prepend("<p style='font-size:8pt;color:gray;text-align:right' class='highest'> Suggestion Box:</p>")},
function(){$(this).parent().prev().find("p").empty()}
);

$("#commentsapply").hover(
function() {
$(this).parent().prev().prepend("<p style='font-size:8pt;color:gray;text-align:right' class='highest'> Describe how you applied Celebrate 2010 at home:</p>")},
function(){$(this).parent().prev().find("p").empty()}
);

$("#submit").hover(
function() {
$(this).parent().append("<p style='font-size:8pt;color:gray;text-align:center' class='highest'> Thanks so much for your help!</p>")},
function(){$(this).parent().find("p").empty()}
);

 });