import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'product_repository.dart';

class AddProductScreen extends ConsumerStatefulWidget {
  const AddProductScreen({super.key});

  @override
  ConsumerState<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends ConsumerState<AddProductScreen> {
  final _barcodeController = TextEditingController();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();

  final _barcodeFocusNode = FocusNode();
  final _nameFocusNode = FocusNode();

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    // Auto-focus barcode field so physical scanner works immediately
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _barcodeFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _barcodeController.dispose();
    _nameController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    _barcodeFocusNode.dispose();
    _nameFocusNode.dispose();
    super.dispose();
  }

  void _onBarcodeSubmitted(String value) {
    if (value.trim().isNotEmpty) {
      _nameFocusNode.requestFocus();
    }
  }

  Future<void> _saveProduct({required bool addAnother}) async {
    final barcode = _barcodeController.text.trim();
    final name = _nameController.text.trim();
    final price = double.tryParse(_priceController.text.trim()) ?? 0.0;
    final stock = double.tryParse(_stockController.text.trim()) ?? 0.0;

    if (barcode.isEmpty || name.isEmpty || price <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields correctly.')),
      );
      return;
    }

    setState(() => _isSaving = true);

    try {
      await ref.read(productRepositoryProvider).addProduct(
            barcode: barcode,
            name: name,
            sellingPrice: price,
            currentStock: stock,
          );

      if (addAnother) {
        // Clear fields for the next rapid entry
        _barcodeController.clear();
        _nameController.clear();
        _priceController.clear();
        _stockController.clear();
        _barcodeFocusNode.requestFocus();
        
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Saved $name. Scan next item!')),
        );
      } else {
        if (!mounted) return;
        Navigator.pop(context);
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving product: $e')),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Product')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _barcodeController,
                focusNode: _barcodeFocusNode,
                decoration: const InputDecoration(
                  labelText: 'Barcode (Scan or Type)',
                  prefixIcon: Icon(Icons.qr_code_scanner),
                ),
                textInputAction: TextInputAction.next,
                onSubmitted: _onBarcodeSubmitted,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _nameController,
                focusNode: _nameFocusNode,
                decoration: const InputDecoration(
                  labelText: 'Product Name',
                ),
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _priceController,
                      decoration: const InputDecoration(
                        labelText: 'Selling Price (₹)',
                      ),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))],
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: _stockController,
                      decoration: const InputDecoration(
                        labelText: 'Opening Stock',
                      ),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))],
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => _saveProduct(addAnother: true),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: _isSaving ? null : () => _saveProduct(addAnother: true),
                child: _isSaving
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Save & Add Another'),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: _isSaving ? null : () => _saveProduct(addAnother: false),
                style: TextButton.styleFrom(
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                child: const Text('Save & Finish', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
