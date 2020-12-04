
var documents = [{
    "id": 0,
    "url": "http://localhost:4000/teaching/fa20-522",
    "title": "Teaching - Econ 522 (Fall 2020)",
    "body": "Econ 522: Law and Economics (Fall 2020): Canvas course site Course Instructor: Prof. Dan Quint Lecture: Tuesdays and Thursdays, 2:30 - 3:45pm Discussion Sections:  Fridays, 9:55 - 10:45am Fridays, 11:00 - 11:50amOffice Hours:  Mondays, 8:00 - 9:00am Mondays, 1:45 - 2:45pm Thursdays, 4:15 - 5:15pm Or by appointmentHow to attend lectures, discussions, and office hours online Discussion Handouts:       Date   Content         Week 1 (9/4 &amp; 9/7)   NO DISCUSSION       Week 2 (9/11 &amp; 9/14)   General Info; Common vs. Civil Law; Efficiency Handout   Solution   Recording       Week 3 (9/18 &amp; 9/21)   Coase Theorem; Bargaining Handout   Solution   Recording       Week 4 (9/25 &amp; 9/28)   Property Law Handout   Solution   Recording       Week 5 (10/2 &amp; 10/5)   Property Law (Cont’d) Handout   Solution   Recording       Week 6 (10/9 &amp; 10/12)   NO DISCUSSION (Exam 1 on 10/8)       Week 7 (10/16 &amp; 10/19)   Contract Law Handout   Solution   Recording       Week 8 (10/23)   Contract Law (Cont’d) Handout   Solution   Recording       Week 9 (10/30)   NO DISCUSSION (Exam 2 on 10/29)       Week 10 (11/6)   Tort Law Handout   Solution   Recording       Week 11 (11/13)   Tort Law (Cont’d) Handout   Solution   Recording       Week 12 (11/20)   NO DISCUSSION (Exam 3 on 11/19)       Week 13 (11/27)   NO DISCUSSION (Thanksgiving Week)       Week 14 (12/4)   Criminal Law Handout   Solution   Recording       Week 15 (12/11)   Review session &amp; extra office hour 1:00pm - 3:30pm (No section in the morning)       Week 16 (12/14)   Final Exam: 12/14 (Mon) 7:45am - 9:45am   "
    }, {
    "id": 1,
    "url": "http://localhost:4000/teaching/sp20-101",
    "title": "Teaching - Econ 101 (Spring 2020)",
    "body": "Econ 101: Principles of Microeconomics (Spring 2020): End of semester TA performance evaluation available here Course Instructor: David Johnson Lecture: Mondays and Wednesdays, 8:25 - 9:40am Office Hours:  Tuesdays, 2:30 - 3:30pm Wednesdays, 2:30 - 3:30pm If you can’t attend either, feel free to send me an email to make an appointmentFinal Exam: May 3 (Sun) "
    }, {
    "id": 2,
    "url": "http://localhost:4000/teaching/fa19-101",
    "title": "Teaching - Econ 101 (Fall 2019)",
    "body": "Econ 101: Principles of Microeconomics (Fall 2019): End of semester TA performance evaluation available here Course Instructor: David Johnson Lecture: Mondays and Wednesdays, 8:25 - 9:40am @ Bascom 272 Office Hours: @ 7218 Social Sciences (7th floor TA resource room)  Tuesdays, 9:15 - 10:15am Thursdays, 2:00 - 3:00pm If you can’t attend either, feel free to send me an email to make an appointmentFinal Exam: Dec 13 (Fri), 7:45 - 9:45am "
    }, {
    "id": 3,
    "url": "http://localhost:4000/hoo/",
    "title": "Research - hoo",
    "body": "[View hoo on GitHub] Horizon of Observation rENA Model for Multimodal Data Analysis What is hoo? Install hoo in R What’s new Upcoming featuresWhat is hoo?: hoo is an R package used for multimodal data analysis. It is used alongside rENA. hoo creates an appropriate ENA accumulated model that can be used by rENA to produce ENA set. You can call rENA plotting functions on such ENA set to generate points and network plots to analyze connections between player interactions. For more on how to interpret ENA model and plotted network, consult Epistemic Analytics Lab at University of Wisconsin-Madison. Install hoo in R: To install this repository in R as a package, run the following commands: install. packages( devtools )devtools::install_github( scaotravis/hoo@v3. 4. 5 )library(hoo)What’s new: Version 3. 4. 5 (May 29, 2019):  Included parameter referenceMode to customize what mode of data the reference line should be when calculating connections within a moving stanza window (defaults to include all modes of data). Version 3. 4. 4 (May 15, 2019):  Fixed a wording issue in hoo. ena. accumulate. data() help document. Version 3. 4. 3 (April 12, 2019):  When replacing the adjacency vectors created by rENA::ena. accumulate. data() with hoo generated adjacency vectors, hoo now uses a more robust grepl() assisted subset method to avoid erroneous replacement. Version 3. 4. 2 (March 24, 2019):  Cleaned up redundant codes.  Included hoo. horizon. DT() method that utilizes data. table structure and lapply() function in attempt to increase performance. Version 3. 3 (March 23, 2019) (pulled on March 24 due to performance decrease) Verison 3. 2 (January 29, 2019):  Now, all methods from hoo comes with prefix hoo. , which helps you distinguish methods called by hoo class. Version 3. 1 (November 14, 2018):  Included function hoo. ena. accumulate. data() to directly generate ENA accumulated model for ENA set creation.  Reordered some arguments for a more logical ordering. Version 3. 0 (November 11, 2018):  Included dataset mock for testing and example demonstration.  windowSize for whole conversation data now takes value 1 (uses the same standard as rENA). Upcoming features:  Directly generate appropriate ENA accumulated model for ENA set creation. (Available since v3. 1) Use type data. table on dataset to increase performance. (Prototype available in v3. 4. 2) Consider C version of hoo to increase loop performance. "
    }, ];

var idx = lunr(function () {
    this.ref('id')
    this.field('title')
    this.field('body')

    documents.forEach(function (doc) {
        this.add(doc)
    }, this)
});
function lunr_search(term) {
    document.getElementById('lunrsearchresults').innerHTML = '<ul></ul>';
    if(term) {
        document.getElementById('lunrsearchresults').innerHTML = "<p>Search results for '" + term + "'</p>" + document.getElementById('lunrsearchresults').innerHTML;
        //put results on the screen.
        var results = idx.search(term);
        if(results.length>0){
            //console.log(idx.search(term));
            //if results
            for (var i = 0; i < results.length; i++) {
                // more statements
                var ref = results[i]['ref'];
                var url = documents[ref]['url'];
                var title = documents[ref]['title'];
                var body = documents[ref]['body'].substring(0,160)+'...';
                document.querySelectorAll('#lunrsearchresults ul')[0].innerHTML = document.querySelectorAll('#lunrsearchresults ul')[0].innerHTML + "<li class='lunrsearchresult'><a href='" + url + "'><span class='title'>" + title + "</span><br /><span class='body'>"+ body +"</span><br /><span class='url'>"+ url +"</span></a></li>";
            }
        } else {
            document.querySelectorAll('#lunrsearchresults ul')[0].innerHTML = "<li class='lunrsearchresult'>No results found...</li>";
        }
    }
    return false;
}

function lunr_search(term) {
    $('#lunrsearchresults').show( 400 );
    $( "body" ).addClass( "modal-open" );
    
    document.getElementById('lunrsearchresults').innerHTML = '<div id="resultsmodal" class="modal fade show d-block"  tabindex="-1" role="dialog" aria-labelledby="resultsmodal"> <div class="modal-dialog shadow-lg" role="document"> <div class="modal-content"> <div class="modal-header" id="modtit"> <button type="button" class="close" id="btnx" data-dismiss="modal" aria-label="Close"> &times; </button> </div> <div class="modal-body"> <ul class="mb-0"> </ul>    </div> <div class="modal-footer"><button id="btnx" type="button" class="btn btn-danger btn-sm" data-dismiss="modal">Close</button></div></div> </div></div>';
    if(term) {
        document.getElementById('modtit').innerHTML = "<h5 class='modal-title'>Search results for '" + term + "'</h5>" + document.getElementById('modtit').innerHTML;
        //put results on the screen.
        var results = idx.search(term);
        if(results.length>0){
            //console.log(idx.search(term));
            //if results
            for (var i = 0; i < results.length; i++) {
                // more statements
                var ref = results[i]['ref'];
                var url = documents[ref]['url'];
                var title = documents[ref]['title'];
                var body = documents[ref]['body'].substring(0,160)+'...';
                document.querySelectorAll('#lunrsearchresults ul')[0].innerHTML = document.querySelectorAll('#lunrsearchresults ul')[0].innerHTML + "<li class='lunrsearchresult'><a href='" + url + "'><span class='title'>" + title + "</span><br /><small><span class='body'>"+ body +"</span><br /><span class='url'>"+ url +"</span></small></a></li>";
            }
        } else {
            document.querySelectorAll('#lunrsearchresults ul')[0].innerHTML = "<li class='lunrsearchresult'>Sorry, no results found. Close & try a different search.</li>";
        }
    }
    return false;
}
    
$(function() {
    $("#lunrsearchresults").on('click', '#btnx', function () {
        $('#lunrsearchresults').hide( 5 );
        $( "body" ).removeClass( "modal-open" );
    });
});