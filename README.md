# AC-iOS 4.3 Final-Retake - Practical

## Objective

Build a blog app for posting images *OR* text posts.

## Summary

The app comprises three view controllers: a feed, an upload page and a login page.
 The designs to follow
will illustrate and specify the design and relationship of these view controllers
though *the design assets are not included and aren't necessary*.
 The backend is powered by Firebase. 

## Login

This app will require the user to log in before he/she can access the rest of the app. 

![Login](https://github.com/C4Q/AC3.2-Final-Retake/blob/master/readme_assets/login.png)


## Main View: Feed

Each post in the feed has *either one* two elements (but not both): a picture or text. The picture is a fixed square the width
of the device and the text is variable height below it, resulting in non-uniform cell heights.

![Feed](https://github.com/C4Q/AC3.2-Final-Retake/blob/master/readme_assets/feed.png)


## Upload View

The upload view had a square text entry view and a square image view. When the user taps on the
image view it  opens ```UIImagePickerController```. Upon selection the image is populated.
Upload will then upload the image. If the text field is populated, text will be uploaded.

Be sure to keep these two fields mutually exclusive as the user is interacting with the view.

![Upload](https://github.com/C4Q/AC3.2-Final-Retake/blob/master/readme_assets/upload.png)

## Backend

### Authentication

Email/Password authentication is enabled so you can register and log users in. 

### Database

The simple schema is illustrated by this diagram:

![Database](https://github.com/C4Q/AC3.2-Final-Retake/blob/master/readme_assets/database.png)

### Storage

The file structure of the storage is illustrated here: 

![Storage](https://github.com/C4Q/AC3.2-Final-Retake/blob/master/readme_assets/storage.png)

Note the relationship between image names and objects in the database.

