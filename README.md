## elm_exercises
my answers to exercises in  ["An Introduction to Elm"](https://guide.elm-lang.org/)

### button

Exercise: One cool thing about The Elm Architecture is that it is super easy to extend as our product requirements change. Say your product manager has come up with this amazing "reset" feature. A new button that will reset the counter to zero.

Answer: [01-button.elm](https://github.com/cjen07/elm_exercises/blob/master/01-button.elm)

### form

Exercises: One cool thing about breaking viewValidation out is that it is pretty easy to augment. If you are messing with the code as you read through this (as you should be!) you should try to:

* Check that the password is longer than 8 characters.
* Make sure the password contains upper case, lower case, and numeric characters.
* Add an additional field for age and check that it is a number.
* Add a "Submit" button. Only show errors after it has been pressed.

Answer: [03-form.elm](https://github.com/cjen07/elm_exercises/blob/master/03-form.elm)

### random

Exercises: Here are some that build on stuff that has already been introduced:

* Instead of showing a number, show the die face as an image.
* Add a second die and have them both roll at the same time.

And here are some that require new skills:

* Instead of showing an image of a die face, use the elm-lang/svg library to draw it yourself.
* After you have learned about tasks and animation, have the die flip around randomly before they settle on a final value. (todo)

Answer: [04-random.elm](https://github.com/cjen07/elm_exercises/blob/master/04-random.elm)

### http

Exercises: To get more comfortable with this code, try augmenting it with skills we learned in previous sections:

* Show a message explaining why the image didn't change when you get an Http.Error.
* Allow the user to modify the topic with a text field.
* Allow the user to modify the topic with a drop down menu.

Answer: [05-http.elm](https://github.com/cjen07/elm_exercises/blob/master/05-http.elm)
