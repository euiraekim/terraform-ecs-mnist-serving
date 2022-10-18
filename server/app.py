from flask import Flask, jsonify, request

from lib import load_model, get_prediction


app = Flask(__name__)

model = load_model()
model.eval()

@app.route('/predict', methods=['POST'])
def predict():
    if request.method == 'POST':
        file = request.files['file']
        img_bytes = file.read()
        class_id = get_prediction(model, image_bytes=img_bytes)
        return jsonify({
            'class': class_id,
            'status': 200,
        })

@app.route('/health', methods=['GET'])
def health():
    return {
        'status': 200,
    }

if __name__ == '__main__':
    app.run(host='0.0.0.0')