


$(function(){
	var App = {
		init: function(){
			this.cacheElements();
			this.bindEvents();
			this.render();
		},
		cacheElements: function(){
			this.$rslide = $(".rslides");
			this.$homeLink = $("#logo-wrapper");
		},
		bindEvents: function(){
			this.$homeLink.on("click", function(){
				window.location = "/";
			});
		},
		render: function(){
			this.$rslide.responsiveSlides({
				maxwidth:940,
				nav:true,
				timeout:8000
			});
		}
	};

	App.init();
});