# /routers/email.py

from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
import base64
import smtplib
from email.message import EmailMessage
import os

router = APIRouter()

class EmailRequest(BaseModel):
    to: str
    subject: str
    body: str
    attachment: str  # base64 encoded PDF
    filename: str = "bill.pdf"

@router.post("/send-email")
async def send_email(req: EmailRequest):
    try:
        msg = EmailMessage()
        msg["Subject"] = req.subject
        msg["From"] = os.getenv("SMTP_SENDER", "your_email@example.com")
        msg["To"] = req.to
        msg.set_content(req.body)

        pdf_bytes = base64.b64decode(req.attachment)
        msg.add_attachment(pdf_bytes, maintype="application", subtype="pdf", filename=req.filename)

        with smtplib.SMTP("smtp.gmail.com", 587) as server:
            server.starttls()
            server.login(os.getenv("SMTP_USER"), os.getenv("SMTP_PASS"))
            server.send_message(msg)

        return {"status": "Email sent"}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
