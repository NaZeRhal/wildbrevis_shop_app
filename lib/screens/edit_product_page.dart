import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wildbrevis_shop_app/providers/product.dart';
import 'package:wildbrevis_shop_app/providers/products_provider.dart';

class EditProductPage extends StatefulWidget {
  static const routeName = '/edit_product';
  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  String _imageUrl = '';
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isInit = true;

  var _editedProduct = ProductProvider(
    id: null,
    name: '',
    price: 0.0,
    description: '',
    imageUrl: '',
  );

  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };

  var _isLoading = false;

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        _editedProduct = Provider.of<ProductsProvider>(context, listen: false)
            .findById(productId);
        _initValues = {
          'title': _editedProduct.name,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          'imageUrl': '',
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // _imageUrlFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if (_validateUrl(_imageUrlController.text) != null) {
        return;
      }
      setState(() {
        _imageUrl = _imageUrlController.text;
      });
    }
  }

  void _saveForm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        _isLoading = true;
      });
      if (_editedProduct.id != null) {
        Provider.of<ProductsProvider>(context, listen: false)
            .updateProduct(_editedProduct.id, _editedProduct);
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
      } else {
        Provider.of<ProductsProvider>(context, listen: false)
            .addProduct(_editedProduct)
            .catchError((error) {
          return showDialog<Null>(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text('An error occured!'),
              content: Text('Something went wrong.'),
              actions: [
                FlatButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: Text('Close'),
                ),
              ],
            ),
          );
        }).then((_) {
          setState(() {
            _isLoading = false;
          });
          Navigator.of(context).pop();
        });
      }
    }
  }

  String _validatePrice(String value) {
    if (value.isEmpty) {
      return 'Enter a price';
    }
    if (double.tryParse(value) == null) {
      return 'Enter a valid number';
    }
    if (double.parse(value) <= 0) {
      return 'Enter a number greater than zero';
    }
    return null;
  }

  String _validateDescription(String value) {
    if (value.isEmpty) {
      return 'Enter a description';
    }
    if (value.length < 10) {
      return 'Should be at least 10 characters long';
    }
    return null;
  }

  String _validateUrl(String value) {
    if (value.isEmpty) {
      return 'Enter an image URL';
    }
    if (!value.startsWith('http') || !value.startsWith('https')) {
      return 'Enter a valid URL';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveForm();
            },
          )
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _initValues['title'],
                      decoration: InputDecoration(
                        labelText: 'Title',
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) =>
                          value.isEmpty ? 'Enter a title' : null,
                      onSaved: (newValue) {
                        _editedProduct = ProductProvider(
                          id: null,
                          name: newValue,
                          price: _editedProduct.price,
                          description: _editedProduct.description,
                          imageUrl: _editedProduct.imageUrl,
                          isFavorite: _editedProduct.isFavorite,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['price'],
                      decoration: InputDecoration(
                        labelText: 'Price',
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      validator: _validatePrice,
                      onSaved: (newValue) {
                        _editedProduct = ProductProvider(
                          id: null,
                          name: _editedProduct.name,
                          price: double.parse(newValue),
                          description: _editedProduct.description,
                          imageUrl: _editedProduct.imageUrl,
                          isFavorite: _editedProduct.isFavorite,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['description'],
                      decoration: InputDecoration(
                        labelText: 'Description',
                      ),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      validator: _validateDescription,
                      onSaved: (newValue) {
                        _editedProduct = ProductProvider(
                          id: null,
                          name: _editedProduct.name,
                          price: _editedProduct.price,
                          description: newValue,
                          imageUrl: _editedProduct.imageUrl,
                          isFavorite: _editedProduct.isFavorite,
                        );
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(top: 8, right: 8),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          child: _editedProduct.imageUrl.isEmpty
                              ? Center(child: Text('Enter a URL'))
                              : FittedBox(
                                  child: Image.network(
                                    _editedProduct.imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Image Url',
                            ),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            focusNode: _imageUrlFocusNode,
                            controller: _imageUrlController,
                            validator: _validateUrl,
                            onFieldSubmitted: (value) {
                              setState(() => _imageUrl = value);
                              _saveForm();
                            },
                            onSaved: (newValue) {
                              _editedProduct = ProductProvider(
                                id: null,
                                name: _editedProduct.name,
                                price: _editedProduct.price,
                                description: _editedProduct.description,
                                imageUrl: newValue,
                                isFavorite: _editedProduct.isFavorite,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
