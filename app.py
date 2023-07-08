from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello():
    return 'Hello, World!'

# Run the application if this file is executed directly
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
