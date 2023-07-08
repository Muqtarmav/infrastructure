from flask import Flask

# Create a Flask application
app = Flask(__name__)

# Define a route and its corresponding function
@app.route('/')
def hello():
    return 'Hello, World!'

# Run the application if this file is executed directly
if __name__ == '__main__':
    app.run()
