# Specifies the base image we're extending
FROM node:13-alpine

# Specify the "working directory" for the rest of the Dockerfile
WORKDIR /src

# Install packages using NPM 5 (bundled with the node:9 image)
COPY ./package.json /src/package.json
COPY ./package-lock.json /src/package-lock.json
RUN npm install --silent

# Add application code
COPY ./app /src/app
COPY ./bin /src/bin
COPY ./public /src/public

# Remove unused vulnerable packages
RUN rm -rf /src/node_modules/handlebars

# Add the nodemon configuration file
COPY ./nodemon.json /src/nodemon.json

# Set environment to "development" by default
ENV NODE_ENV development

# Allows port 3000 to be publicly available
EXPOSE 3000

# Set default user
USER node

# The command uses nodemon to run the application
CMD ["node", "node_modules/.bin/nodemon", "-L", "bin/www"]
