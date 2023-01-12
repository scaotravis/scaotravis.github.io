jQuery(document).ready(function($){
  
  // fix for stupid ie object cover
  if (document.documentMode || /Edge/.test(navigator.userAgent)) {
    jQuery('.featured-box-img-cover').each(function(){
        var t = jQuery(this),
            s = 'url(' + t.attr('src') + ')',
            p = t.parent(),
            d = jQuery('<div></div>');

        p.append(d);
        d.css({
            'height'                : '290',
            'background-size'       : 'cover',
            'background-repeat'     : 'no-repeat',
            'background-position'   : '50% 20%',
            'background-image'      : s
        });
        t.hide();
    });
  }

  // alertbar later
  $(document).scroll(function () {
      var y = $(this).scrollTop();
      if (y > 280) {
          $('.alertbar').fadeIn();
      } else {
          $('.alertbar').fadeOut();
      }
  });


  // Smooth on external page
  $(function() {
    setTimeout(function() {
      if (location.hash) {
        /* we need to scroll to the top of the window first, because the browser will always jump to the anchor first before JavaScript is ready, thanks Stack Overflow: http://stackoverflow.com/a/3659116 */
        window.scrollTo(0, 0);
        target = location.hash.split('#');
        smoothScrollTo($('#'+target[1]));
      }
    }, 1);

    // taken from: https://css-tricks.com/snippets/jquery/smooth-scrolling/
    $('a[href*=\\#]:not([href=\\#])').click(function() {
      if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
        smoothScrollTo($(this.hash));
        return false;
      }
    });

    function smoothScrollTo(target) {
      target = target.length ? target : $('[name=' + this.hash.slice(1) +']');

      if (target.length) {
        $('html,body').animate({
          scrollTop: target.offset().top
        }, 1000);
      }
    }
  });
  
  // Hide Header on on scroll down
  // var didScroll;
  // var lastScrollTop = 0;
  // var delta = 5;
  // var navbarHeight = $('nav').outerHeight();

  // $(window).scroll(function(event){
  //     didScroll = true;
  // });

  // setInterval(function() {
  //     if (didScroll) {
  //         hasScrolled();
  //         didScroll = false;
  //     }
  // }, 25);

  function hasScrolled() {
      var st = $(this).scrollTop();
      
      // Make sure they scroll more than delta
      if(Math.abs(lastScrollTop - st) <= delta)
          return;

      // If they scrolled down and are past the navbar, add class .nav-up.
      // This is necessary so you never see what is "behind" the navbar.
      if (st > lastScrollTop && st > navbarHeight){
          // Scroll Down            
          $('nav').removeClass('nav-down').addClass('nav-up'); 
          $('.nav-up').css('top', - $('nav').outerHeight() + 'px');
         
      } else {
          // Scroll Up
          if(st + $(window).height() < $(document).height()) {               
              $('nav').removeClass('nav-up').addClass('nav-down');
              $('.nav-up, .nav-down').css('top', '0px');             
          }
      }

      lastScrollTop = st;
  }
      
  $('.site-content').css('margin-top', $('header').outerHeight() + 'px');  
  
  // Spoilers
  $(document).on('click', '.spoiler', function() {
    $(this).removeClass('spoiler');
  }); 

  // Dots modification
  if (window.location.href.indexOf('teaching/sp22-310') > 0) {
    var urlLink = '<a href="/teaching/sp22-310" class="active">Sp22: 310</a> <a id="dots-text" onmouseenter="expandingMenu()">More...</a>'
    document.getElementById("dots").innerHTML = urlLink; 
    document.close(); 
  } else if (window.location.href.indexOf('teaching/fa21-310') > 0) {
    var urlLink = '<a href="/teaching/fa21-310" class="active">Fa21: 310</a> <a id="dots-text" onmouseenter="expandingMenu()">More...</a>'
    document.getElementById("dots").innerHTML = urlLink; 
    document.close(); 
  } else if (window.location.href.indexOf('teaching/sp21-400') > 0) {
    var urlLink = '<a href="/teaching/sp21-400" class="active">Sp21: 400</a> <a id="dots-text" onmouseenter="expandingMenu()">More...</a>'
    document.getElementById("dots").innerHTML = urlLink; 
    document.close(); 
  } else if (window.location.href.indexOf('teaching/fa20-522') > 0) {
    var urlLink = '<a href="/teaching/fa20-522" class="active">Fa20: 522</a> <a id="dots-text" onmouseenter="expandingMenu()">More...</a>'
    document.getElementById("dots").innerHTML = urlLink; 
    document.close(); 
  } else if (window.location.href.indexOf('teaching/sp20-101') > 0) {
    var urlLink = '<a href="/teaching/sp20-101" class="active">Sp20: 101</a> <a id="dots-text" onmouseenter="expandingMenu()">More...</a>'
    document.getElementById("dots").innerHTML = urlLink; 
    document.close(); 
  } else if (window.location.href.indexOf('teaching/fa19-101') > 0) {
    var urlLink = '<a href="/teaching/fa19-101" class="active">Fa19: 101</a> <a id="dots-text" onmouseenter="expandingMenu()">More...</a>'
    document.getElementById("dots").innerHTML = urlLink; 
    document.close(); 
  }

  // Get the element with default id and click on it
  if (window.location.href.indexOf('teaching/sp21-400/#default-Travis') > 0) {
    window.localStorage.setItem('activeTab', 'Travis');
  } else if (window.location.href.indexOf('teaching/sp21-400/#default-Zhuoli') > 0) {
    window.localStorage.setItem('activeTab', 'Zhuoli');
  }

  var activeTab = window.localStorage.getItem('activeTab');
  if (activeTab) {
      openPage("For-" + activeTab, document.getElementById("default-" + activeTab)); 
  }

});   

// deferred style loading
var loadDeferredStyles = function () {
var addStylesNode = document.getElementById("deferred-styles");
var replacement = document.createElement("div");
replacement.innerHTML = addStylesNode.textContent.innerHTML; 
document.body.appendChild(replacement);
addStylesNode.parentElement.removeChild(addStylesNode);
};
var raf = window.requestAnimationFrame || window.mozRequestAnimationFrame ||
window.webkitRequestAnimationFrame || window.msRequestAnimationFrame;
if (raf) raf(function () {
window.setTimeout(loadDeferredStyles, 0);
});
else window.addEventListener('load', loadDeferredStyles);

// full page tab
function openPage(pageName, elmnt) {
  // Hide all elements with class="tabcontent" by default
  var i, tabcontent, tablinks;
  tabcontent = document.getElementsByClassName("tabcontent");
  for (i = 0; i < tabcontent.length; i++) {
    if (tabcontent[i].classList.contains("selected")) {
      tabcontent[i].classList.remove("selected"); // remove all tabcontents with active class
    }
  }

  // Remove the background color of all tablinks/buttons
  tablinks = document.getElementsByClassName("tablink");
  for (i = 0; i < tablinks.length; i++) {
    tablinks[i].style.backgroundColor = "";
    if (tablinks[i].classList.contains("active")) {
      tablinks[i].classList.remove("active"); // remove all other links with active class
    }
  }

  // Add the specific color to the button used to open the tab content
  elmnt.classList.add("active"); 

  // Change tabcontent to selected
  document.getElementById(pageName).classList.add("selected"); 

  document.close(); 
}

// Save state of active tab
$(function() {
  $('button[data-toggle="tab"]').on('click', function(e) {
    window.localStorage.setItem('activeTab', $(e.target).attr('href'));
  });
});

// Expand menu
function expandingMenu() {
  var dots = document.getElementById("dots");
  var moreText = document.getElementById("more");

  dots.style.display = "none";
  moreText.style.display = "inline";
}

// Close menu
function closingExpandedMenu() {
  var dots = document.getElementById("dots");
  var moreText = document.getElementById("more");

  dots.style.display = "block";
  moreText.style.display = "none";
}