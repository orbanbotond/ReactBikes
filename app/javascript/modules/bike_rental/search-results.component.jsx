import React, { Component } from 'react';
import { Badge, Table, Button } from 'reactstrap';
import PropTypes from 'prop-types';
import Rater from 'react-rater'
import 'react-rater/lib/react-rater.css';
import "react-toggle/style.css" 

export default class SearchResult extends Component {
  modelName(model_id){
    const model = this.props.models.find(element=>{
      return element.id === model_id;
    });

    return model.text;
  }

  handleReserve(id) {
    this.props.reserveHandler(id);
  }

  render(){
    const { collection } = this.props;

    let result;

    if(collection){
      if(collection.length >0){
        result = (
          <Table striped hover size="sm">
            <thead>
              <tr>
                <th>#</th>
                <th>Color</th>
                <th>Weight</th>
                <th>Average Rating</th>
                <th>Latitude</th>
                <th>Longitude</th>
                <th>Model</th>
                <th>Picture</th>
                <th>Reserve</th>
              </tr>
            </thead>
            <tbody>
              { collection.map( model =>
                  <tr key={model.id}>
                    <th scope="row">{model.id}</th>
                    <td>{model.color}</td>
                    <td>{model.weight}</td>
                    <td>
                      <Rater total={5}
                             rating={model.average_rating}
                             interactive={false} />
                    </td>
                    <td>{model.latitude}</td>
                    <td>{model.longitude}</td>
                    <td>{this.modelName(model.bike_model_id)}</td>
                    <td>
                      {model.image_url && (
                        <img src={model.image_url} width="50"/>
                      )}
                    </td>
                    <td>
                      <Button outline color="success" size="sm" onClick={() => this.handleReserve(model.id)}>Reserve</Button>
                    </td>
                  </tr>
              )}
            </tbody>
          </Table>
        )
      }else{
        result = <h3><Badge color="warning">No Results</Badge>Please refine your search criteria!</h3>
      }
    }

    return (
      <div>
        {result}
      </div>
    );
  }
}

// List.contextTypes = {
//   router: React.PropTypes.object.isRequired
// };

SearchResult.propTypes = {
  collection: PropTypes.array,
  models: PropTypes.array.isRequired,
}
