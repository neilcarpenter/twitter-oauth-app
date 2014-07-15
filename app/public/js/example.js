(function() {

	var userData = {};

	function onLoginClick(e) {

		e.preventDefault();

		var url  = '/auth/twitter';
		var w    = 680;
		var h    = 540;
		var left = ( screen.availWidth  - w ) >> 1;
		var top  = ( screen.availHeight - h ) >> 1;
		var opts = 'width=' + w + ',height=' + h + ',top=' + top + ',left=' + left + ',location=0,menubar=0,scrollbars=0,status=0,toolbar=0,resizable=0';

		window._loginWindow = window.open(url, 'loginWindow', opts);

	}

	function onExampleClick(e) {

		var $this, data, req;

		$this = $(this);

		$this.text('Getting tweets...');

		data = {
			user_id     : userData.id,
			token       : userData.token,
			tokenSecret : userData.tokenSecret
		};

		req = $.ajax({
			type : 'POST',
			url  : '/api/twitter/getTweets',
			data : data
		});

		req.done(function(res) {

			$this.remove();

			var $ol = $('<ol />');

			res.tweets.forEach(function(tweet){
				$ol.append('<li>' + tweet.text +'</li>');
			});

			$('body').append($ol);

		});

	}

	function callback(data) {

		userData = data;

		window._loginWindow.close();

		var newDom = '<p>Logged in as <strong>' + userData.name + '</strong>, user id = <strong>' + userData.id + '</strong>';
		newDom += '<p><button data-api-example>Get 5 latest tweets for ' + userData.name + '</button></p>';

		$('[data-login]').replaceWith(newDom);

	}

	$(function() {

		var $doc = $(document);
		$doc.on('click', '[data-login]', onLoginClick);
		$doc.on('click', '[data-api-example]', onExampleClick);

		window.$loginDfd = $.Deferred();
		window.$loginDfd.done(callback);
		window.$loginDfd.fail(function() { alert('there was an issue logging in...'); });

	});

}).call(this);