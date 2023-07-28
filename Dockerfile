FROM python:3

WORKDIR /usr/src/myapp

COPY ./ ./

ARG TOTP_SECRET
RUN test -n "$TOTP_SECRET" || (echo "TOTP_SECRET  not set" && false)
ENV TOTP_SECRET=$TOTP_SECRET

RUN /bin/bash -c 'pip3 install -r requirements.txt'

CMD python3 totp.py $TOTP_SECRET

# Build your image with totp secret: docker build --build-arg="TOTP_SECRET=XXXXXXXXXXXXXXXX" -t hmrc/totp-generator-python:latest .
# Run the container based off the image: docker run -it --rm hmrc/totp-generator-python:latest