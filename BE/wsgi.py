"""
WSGI config for DrowsyGuard Backend.
It exposes the WSGI callable as a module-level variable named `application`.
"""
import os
from app import create_app

# Create the Flask application instance
application = create_app()

# This block ensures the application only runs when the script is executed directly
if __name__ == "__main__":
    # Get the port from the environment variable or use 5000 as default
    port = int(os.environ.get("PORT", 5000))
    # Run the application
    application.run(host='0.0.0.0', port=port, debug=os.environ.get('FLASK_DEBUG', 'False').lower() == 'true')
