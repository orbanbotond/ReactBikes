import React, { Component } from 'react';
import { BikesAxios as Axios, Routes } from '@routes/routes';
import { Button } from 'reactstrap';

class PictureUpload extends Component {
  constructor(props) {
    super(props);

    this.state = {
      url: props.model.image_url,
      selectedFile: null
    };
  }

  fileSelectedHandler(event) {
    this.setState({
      selectedFile: event.target.files[0]
    },() => {
      this.fileUploadHandler();
    })
  }

  fileUploadHandler() {
    const fd = new FormData();
    fd.append('bike[picture]', this.state.selectedFile, this.state.selectedFile.name);

    Axios().put(Routes.Rails.member_route("bycicle", this.props.model.id), fd,{
      onUploadProgress: progressEvent => {
        console.log("Upload progress:" + Math.round(progressEvent.loaded / progressEvent.total * 100));
      }        
    })
    .then(responseObj => {
      this.setState({
        url: responseObj.data.image_url
      })
    })
  }

  render(){
    return (
      <div className="container-fluid">
        { this.state.url &&
          <div className="text-center">
            <img className="mx-auto d-bloc" src={this.state.url} width="50"/>
          </div>
        }
        <input 
          style={{display: 'none'}} 
          type="file" 
          onChange={this.fileSelectedHandler} 
          ref={fileInput => this.fileInputReference = fileInput} />
        <Button 
          className="col-lg-12" 
          outline 
          size="sm" 
          color="success" 
          onClick={() => this.fileInputReference.click()}>{this.state.url ? "Change Picture" : "Upload Picture" }</Button>
      </div>
    )
  }

}

export default PictureUpload;
