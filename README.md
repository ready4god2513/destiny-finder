# Todo List

See Pivotal Tracker
`https://www.pivotaltracker.com/projects/442841`

### Foxycart API KEY
`ZXfxZZFuKRzaWQyR3yexR2VUIjHFHvMxjXU9MvtscSs3CUKviPWZKINkWmUu`


### Known Issues

1. Foxycart caches the templates for checkout and the cart.  Any time the templates are changed we need to ensure that both the cart and checkout templates are recached. [Checkout Template](https://admin.foxycart.com/admin.php?ThisAction=EditTemplate&template=checkout) & [Cart Template](https://admin.foxycart.com/admin.php?ThisAction=EditTemplate&template=cart)

2. Foxycart does not manage products.  This means that in order to add new products we either need to build an interface for admins or we need to hard code products.  At this point we are going to hard-code.

3. Because Foxycart does not manage products, prices are passed via form fields.  This is obviously problematic.  They do have a way to encrypt the prices, however the library is only available for PHP at this point.  This can be handled 1 of 3 ways- Write an encryption library for ColdFusion, a request to our server which then makes an API call to Foxycart, or just leave everything in the clear.  For initial development everything will be left in the clear until the team discusses the best solution.