$('.dropdown-toggle').dropdown();

$(document).ready(function() {
    $(".nav-link, .support_link").on('click', function (event) {
        // Make sure this.hash has a value before overriding default behavior
        if (this.hash !== "") {
            // Prevent default anchor click behavior
            event.preventDefault();

            // Store hash
            var hash = this.hash;

            // Using jQuery's animate() method to add smooth page scroll
            // The optional number (900) specifies the number of milliseconds it takes to scroll to the specified area
            $('html, body').animate({
                scrollTop: $(hash).offset().top
            }, 500, function () {

                // Add hash (#) to URL when done scrolling (default click behavior)
                window.location.hash = hash;
            });
        } // End if
    });
    var sidebar_toggled_btn = document.getElementById('sidebarToggledBtn');
    var sidebar_toggled = document.getElementById('sidebarToggled');
    var content_toggled = document.getElementById('contentToggled');
    
    var sidebar_length = sidebar_toggled.classList.length;
    var content_length = content_toggled.classList.length;

    sidebar_toggled_btn.onclick = function() {
        if ((sidebar_toggled.classList[sidebar_length - 1] == "toggled") && (content_toggled.classList[content_length - 1] == "toggled")) {
            sidebar_toggled.classList.remove("toggled");
            content_toggled.classList.remove("toggled");
        } else {
            sidebar_toggled.classList.add("toggled");
            content_toggled.classList.add("toggled");
        }
    };
    window.onresize = function() {
        if(window.outerWidth < 768) {
            sidebar_toggled.classList.add("toggled");
            content_toggled.classList.add("toggled");
        } else {
            sidebar_toggled.classList.remove("toggled");
            content_toggled.classList.remove("toggled");
        }
        
    }
    
    window.onresize();
});