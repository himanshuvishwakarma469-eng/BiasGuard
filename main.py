from fastapi import FastAPI, UploadFile, File
import pandas as pd
import google.generativeai as genai
import io

app = FastAPI()

# Configure Gemini API
genai.configure(api_key="YOUR_GEMINI_API_KEY")

@app.post("/analyze")
async def analyze_bias(file: UploadFile = File(...)):
    contents = await file.read()
    df = pd.read_csv(io.BytesIO(contents))
    
    # Analyze column distribution
    summary = df.describe().to_string()
    
    # Gemini Analysis
    model = genai.GenerativeModel('gemini-pro')
    response = model.generate_content(f"Analyze this data for potential bias: {summary}")
    
    return {"analysis": response.text}
