Rails.application.config.middleware.use OmniAuth::Builder do
	provider :twitter, "EGtAiRXlnFzX90MPtkHA", "OkDiA6C0Ej2yBg9Jh6Rdhoxc25b5aMfQLRwbY1Mw0U"
		{
		  :secure_image_url => 'true',
		  :image_size => 'original',
		  :authorize_params => {
		    :force_login => 'true',
		    :lang => 'pt'
		  }
		}
end