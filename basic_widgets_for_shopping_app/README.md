# basic_widgets_for_shopping_app

## Product Class

- Define a class named Product.
- The class should have a constructor that takes a required parameter `name`.

## artChangedCallback Function

- Define a function named `CartChangedCallback`.
- The function should have two parameters: `Product product` and `bool inCart`.

## ShoppingListItem Class

- Define a class named ShoppingListItem which extends `StatelessWidget`.
- The class should have three required parameters: `Product product`,
  `bool inCart`, and `CartChangedCallback onCartChanged`.
- Define a private method named `_getColor` which takes a `BuildContext`
  parameter and returns a `Color`.
- Define a private method named `_getTextStyle` which takes a `BuildContext`
  parameter and returns a `TextStyle`.
- Override the `build` method and return a `ListTile` widget that has an
  `onTap` event that calls the `onCartChanged` function.
- The `ListTile` widget should have a `CircleAvatar` widget for the `leading`
  widget, which displays the first letter of the product's name.
- The `ListTile` widget should have a `Text` widget for the `title`, which
  displays the product's name, and optionally applies a line-through
  decoration if the product is already in the cart.

## ShoppingList Class

- Define a class named ShoppingList which extends `StatefulWidget`.
- The class should have one required parameter: `List<Product> products`.
- Define a private set variable named `_shoppingCart` to keep track of
  products in the cart.
- Define a private method named `_handleCartChanged` which takes a
  `Product product` and `bool inCart` parameter.
- Override the `build` method and return a `Scaffold` widget that has a
  `ListView` widget as its `body`.
- The `ListView` widget should have a `padding` and a `children` property.
- The `children` property should be a list of `ShoppingListItem` widgets
  that are created by mapping over the `products` list, passing in the
  appropriate parameters, and converting it to a list.

## Main Function

- Define the `main` function, which calls `runApp`.
- The `runApp` function returns a `MaterialApp` widget, which has a `title`
  and a `home` property.
- The `home` property should be an instance of the `ShoppingList` widget,
  with a list of products.
