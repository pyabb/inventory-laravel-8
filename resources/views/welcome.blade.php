@extends('include.master')

@section('title','Inventory | Dashboard')

@section('page-title','Dashboard')

@section('content')
    <info-box></info-box>
@endsection

@push('script')
    @vite('resources/js/dashboard.js')
@endpush