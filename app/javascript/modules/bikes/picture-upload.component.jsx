import React, { Component } from 'react';
import { BikesAxios as Axios, Routes } from '@routes/routes';

class PictureUpload extends Component {
  state = {
    selectedFile: null
  }

  fileSelectedHandler = event => {
    this.setState({
      selectedFile: event.target.files[0]
    })
    console.log(event.target.files[0]);
  }

  fileUploadHandler = () => {
    const fd = new FormData();
    fd.append('bike[picture]', this.state.selectedFile, this.state.selectedFile.name);
      Axios().put(Routes.Rails.member_route("bycicle",this.props.model.id), fd)
      .then(res => {
        console.log(res);
      })
  }

  render(){
    return (
      <div>
        <input type="file" onChange={this.fileSelectedHandler} />
        <button onClick={this.fileUploadHandler}>Change</button>
      </div>
    )
  }

}

export default PictureUpload;
