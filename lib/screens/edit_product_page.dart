import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:wildbrevis_shop_app/providers/product.dart';

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

  var _editedProduct = ProductProvider(
    id: null,
    name: '',
    price: 0.0,
    description: '',
    imageUrl: '',
  );

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.dispose();
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
      print(_editedProduct.name);
      print(_editedProduct.description);
      print(_editedProduct.price);
      print(_editedProduct.imageUrl);
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
    // if (!value.endsWith('.png') ||
    //     !value.endsWith('.jpg') ||
    //     !value.endsWith('.jpeg')) {
    //   return 'Enter a valid image URL';
    // }
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
              FocusScope.of(context).requestFocus(new FocusNode());
              _saveForm();
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                textInputAction: TextInputAction.next,
                validator: (value) => value.isEmpty ? 'Enter a title' : null,
                onSaved: (newValue) {
                  _editedProduct = ProductProvider(
                    id: null,
                    name: newValue,
                    price: _editedProduct.price,
                    description: _editedProduct.description,
                    imageUrl: _editedProduct.imageUrl,
                  );
                },
              ),
              TextFormField(
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
                  );
                },
              ),
              TextFormField(
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
                    child: _imageUrl.isEmpty
                        ? Center(child: Text('Enter a URL'))
                        : FittedBox(
                            child: Image.network(
                              _imageUrl,
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
