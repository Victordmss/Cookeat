# Cookeat 
A Flutter application.

## Getting Started
The idea is to create a flutter application allowing any user to have his **own personal recipe management account**. Each user will be able to list his **favorite recipes** :fork_and_knife: on his Cookeat menu. He will also be able to view nutritional and statistical information about his recipes :curry:, ingredients :bread: and food preferences :pizza:. Each user will be able to order a random recipe corresponding to a specific meal (breakfast :coffee:, lunch :hamburger:, dinner :ramen:...)

## Cookeat 
<img src=screenshot/connexion_screen.png width=200>

The first page of the cookeat application is this one 📱. You can see several options. If the user discovers the application, he can register with the "register" button. If the user already has an account, he can connect with his email and his password 🔐.
In case of forgotten password, (a pop-up will indicate the type of error), an option allows him to reset it by mail 📧.
 
<img src=screenshot/forgotpass_screen.png width=200>

The password reset page is this one. A pop-up will let you know if the email has been sent or if an error has occurred (wrong login for example). Once the email has been sent, the user must proceed directly with the URL link included in it. After that, he can retry to connect with his own new password. 🔓

<img src=screenshot/register_screen.png width=200>

If the user is new, he/she must register in order to have his/her own account. The "register" button brings to this page, the register page. Each user needs to give some information in order to use Cookeat. For now, it is just his firstname, name, age, email and password 📂. 

<img src=screenshot/firebase_auth.png width=600>

All the backend authentification process is used with firebase auth. User's data are stored in firebase database (non-relational database) 💾. Thank to that, we will be able to connect each recipe to his owner and to manage user's data.

<img src=screenshot/successful_inscription.png width=200>
A pop up will tell when the registration is over. If there is a problem, it will describe the error to help the user to correct it ✔️.


<br><img src=screenshot/home_page.png width=200>
<br><br>
When the user is connected, he will be directed to the Cookeat Home Page 🏠. This page allows him to use all the Cookeat features :tada:.

<br>
He can for example see all his recipes with a dynamic page :tada:.
<img src=screenshot/recette_list.png width=200>

If he wants, each user is able to add their own recipe by clicking on the add button (top right of the screen), a page will show them all the informations they need to fill in

<img src=screenshot/add_recette.png width=200>


If he fill the form, he can add the recipe and add the recipe to his account. 

<img src=screenshot/add_recette_full.png width=200>


Then, thanks to the dynamic page, he is able to see the new recipe with all its informations.

<img src=screenshot/recette_added.png width=200>


## In progress
--> Deleting of recipes on your own account

## Future features
--> Random recipe proposal depending on the meal requested
--> Ingredient management (recipe, calories, etc.)
