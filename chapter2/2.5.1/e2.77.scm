; why to add the following code to complex package?
(put 'magnitude '(complex) magnitude)

; reason:
In controller, the defined complex number has the following form:
'(complex rectangular 1 . 1)

To compute its magnitude, we have an already defined method in 
our table:
(put 'magnitude '(rectangular) magnitude)

In order to find this method in the table, we need a complex number that has type rectangular, instead of complex:
'(rectangular 1 . 1)
So this method is not usable from controller.

We can export the magnitude method from complex package:
(put 'magnitude '(complex) magnitude)
This way, we can find the magnitude method when running:
(magnitude z) in which z is like (complex rectangular 1 . 1)

When computing, (magnitude z) first translates to:
(apply magnitude '(rectangular 1 . 1))
This is equivalent to
(magnitude '(complex)) which is:
(apply-generic 'magnitude '(rectangular 1 . 1))

Then we fetch the magnitude method from the table which is exported from rectangular package.

In the above procedure, the message to compute magnitude is first passed to complex package, then passed downwords to the rectangular subpackage.




